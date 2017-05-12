#
PROJECT=embeddartvmng
PRJ_SOURCE = src
PRJ_INCLUDE = src
# Change to your Dart SDK root
DART_SDK_ROOT = /home/stevehamblett/Development/google/dart/build/dart-sdk/sdk
DART_BUILD_ROOT ?= $(DART_SDK_ROOT)/out/ReleaseX64/obj
DART_API_INCLUDE= $(DART_SDK_ROOT)/runtime/include
DART_BIN_INCLUDE=$(DART_SDK_ROOT)/runtime/bin
DART_API_LIB= $(DART_BUILD_ROOT)/runtime
DART_BIN_LIB= $(DART_BUILD_ROOT)/runtime/bin
LIB_RELEASE=build/lib

#
CPP = g++
CPP_FLAGS = -g -pipe -fexceptions -Wno-deprecated -Wall -Wno-sign-compare -std=c++11 -D_REENTRANT -DNDEBUG
CPP_EXE_FLAGS = $(CPP_FLAGS)
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
PROJECT_INCLUDES = -I$(DART_API_INCLUDE) \
		   		   -I$(DART_BIN_INCLUDE) 
		  
INCLUDES = \
	$(PROJECT_INCLUDES) \
	-I$(PRJ_INCLUDE)

################################################################################
#
#	Libraries
#
################################################################################
LIBS_AR = -L$(DART_API_LIB) \
          -L$(DART_BIN_LIB)
          
LIBS = $(LIBS_AR)

LIBS_RELEASE = $(LIBS) -L$(LIB_RELEASE) 

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
	
all: create $(BIN_DIR_RELEASE)/$(EXE)

$(BIN_DIR_RELEASE)/$(EXE): $(RELEASE_OBJ)
	@@echo "Linking '$@'..."
	@@$(LD) $(AR_FLAGS) -o $@ $(LIBS_RELEASE) $(RELEASE_OBJ)
	@@echo "$@ created"

clean:
	@@echo "Cleaning ..."
	@@$(RM) $(BIN_DIR_RELEASE)/$(EXE)
	@@$(RM) $(RELEASE_OBJ)

