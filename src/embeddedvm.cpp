/*
 * embeddedvm.cpp
 *
 *  Created on: May 10, 2017
 *      Author: stevehamblett
 */

#include <unistd.h>
#include <sys/param.h>

#include "dart_api.h"
#include "embedded_dart_io.h"

#include "embeddedvm.h"

EmbeddedVM::EmbeddedVM() :
		_scriptPath(NULL), _vm_isolate_snapshot_buffer(NULL), _isolate_snapshot_buffer(
				NULL) {

}

EmbeddedVM::EmbeddedVM(const char* scriptName) :
		_vm_isolate_snapshot_buffer(NULL), _isolate_snapshot_buffer(NULL) {
//	std::string scriptName1(scriptName);
//	char temp[MAXPATHLEN];
//	_scriptPath = "";
//	char* ret = getcwd(temp, MAXPATHLEN);
//	if (ret == NULL) {
//		//printf("EmbeddedVM - failed to get CWD\n");
//	} else {
//		std::string cwd(temp);
//		_scriptPath = cwd + scriptName1;
//	}

}

EmbeddedVM::~EmbeddedVM() {

}

int EmbeddedVM::initializeVM() {

	if (_scriptPath == NULL) {
		//printf("Embedded VM, no script path\n");
		return -1;
	}

	const char* kDartArgs[] = { "--enable_asserts", "--enable_type_checks",
			"--error_on_bad_type", "--error_on_bad_override" };

	dart::bin::BootstrapDartIo();
	Dart_SetVMFlags(sizeof(kDartArgs), kDartArgs);
	Dart_InitializeParams params = { };
	params.version = DART_INITIALIZE_PARAMS_CURRENT_VERSION;
	params.vm_snapshot_data = _vm_isolate_snapshot_buffer;
	char* error = Dart_Initialize(&params);
	if (error) {
		//printf("EmbeddedVM - failed to initialize the VM - error is %s\n", error);
	}

	return 0;
}

