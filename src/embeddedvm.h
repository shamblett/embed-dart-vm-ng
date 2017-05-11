/*
 * embeddedvm.h
 *
 *  Created on: May 10, 2017
 *      Author: stevehamblett
 */

#include <iostream>

#ifndef SRC_EMBEDDEDVM_H_
#define SRC_EMBEDDEDVM_H_

/**
 * The embedded Dart VM class
 */
class EmbeddedVM {

public:

	EmbeddedVM();
	EmbeddedVM(std::string scriptName);
	~EmbeddedVM();

	/**
	 * Initialize the VM
	 */
	int initializeVM();

private:

	std::string _scriptPath;

   char* const _vm_isolate_snapshot_buffer;
   char* const _isolate_snapshot_buffer;
};


#endif /* SRC_EMBEDDEDVM_H_ */
