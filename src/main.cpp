/*
 * main.cpp
 *
 *  Created on: May 10, 2017
 *      Author: stevehamblett
 */
#include <cstdlib>


#include "embeddedvm.h"

/**
 * Main entry point, initializes the VM and runs the supplied script.
 * VM options are preset, checked mode is on, the package root is the current
 * directory. Trace loading is also on to aid in package path debugging.
 * The supplied Dart script must of course have a main entry point.
 */
int main(int argc, const char** argv) {

	if ( argc == 1) {
		//printf("Dart Embedded VM test - please supply a dart script\n");
		return -1;
	}
	const char* script = argv[1];
	//printf("Hello from the Dart Embedded VM test, running script %s\n", script);

	EmbeddedVM vm(script);

	// Initialize the VM
	int ret = vm.initializeVM();
	if ( ret != 0 ) {
		//printf("Failed to initialize the VM - exiting\n");
		return -1;
	}

	return 0;
}



