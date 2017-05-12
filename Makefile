#
PROJECT=embeddartvmng
PRJ_SOURCE = src
PRJ_INCLUDE = src
# Change to your Dart SDK root
DART_SDK_ROOT = /home/stevehamblett/Development/google/dart/build/dart-sdk/sdk
DART_BUILD_ROOT ?= $(DART_SDK_ROOT)/out/ReleaseX64/obj
DART_RUNTIME_INCLUDE= $(DART_SDK_ROOT)/runtime
DART_API_INCLUDE= $(DART_RUNTIME_INCLUDE)/include
DART_BIN_INCLUDE=$(DART_RUNTIME_INCLUDE)/bin
DART_API_LIB= $(DART_BUILD_ROOT)/runtime
DART_BIN_LIB= $(DART_BUILD_ROOT)/runtime/bin
DART_VM_LIB= $(DART_BUILD_ROOT)/runtime/vm
LIB_RELEASE=build/lib

#
CPP = g++
CPP_FLAGS = -g -pipe -fexceptions -Wno-deprecated -Wall -Wno-sign-compare -std=c++11 
CPP_EXE_FLAGS = $(CPP_FLAGS) -D_REENTRANT -DNDEBUG -DDISALLOW_ALLOCATION
#
LD = g++
#
AR = ar
AR_FLAGS = -rcs

#
MV = mv -f
RM = rm -f

################################################################################
#
#	Include files
#
################################################################################
PROJECT_INCLUDES = -I$(DART_RUNTIME_INCLUDE) \
				   -I$(DART_API_INCLUDE) \
		   		   -I$(DART_BIN_INCLUDE) 
		  
INCLUDES = -I$(PRJ_INCLUDE) \
		     $(PROJECT_INCLUDES) 

################################################################################
#
#	Libraries
#
################################################################################
LIBS_AR = -L$(DART_API_LIB) \
          -L$(DART_BIN_LIB) \
          -L$(DART_VM_LIB)
          
LIBS = $(LIBS_AR)

LIBS_RELEASE = $(LIBS) -L$(LIB_RELEASE) \
               -ldart_builtin -ldart -ldart_platform

################################################################################
#
#	Compilation rules for .cpp files
#
################################################################################
.SUFFIXES: .cpp
	
$(LIB_RELEASE)/%.o:	$(PRJ_SOURCE)/%.cpp
	@@echo "Compiling'$<'..."
	$(CPP)  -c $(CPP_EXE_FLAGS) -o $@ -I. $(INCLUDES) $< 
	
################################################################################
#
#	Object files 
#
################################################################################

OBJ_FILES = \
		main.o \
		embeddedvm.o 

RELEASE_OBJ =    $(addprefix $(LIB_RELEASE)/, $(OBJ_FILES))

################################################################################
#
#	Dependency rules
#
################################################################################
EXE = embeddedvm

create:
	@@mkdir -p $(LIB_RELEASE)
	
all: create $(LIB_RELEASE)/$(EXE)

$(LIB_RELEASE)/$(EXE): $(RELEASE_OBJ)
	@@echo "Linking '$@'..."
	$(LD) -o $@ $(LIBS_RELEASE) $(RELEASE_OBJ)
	@@echo "$@ created"

clean:
	@@echo "Cleaning ..."
	@@$(RM) $(LIB_RELEASE)/$(EXE)
	@@$(RM) $(RELEASE_OBJ)

