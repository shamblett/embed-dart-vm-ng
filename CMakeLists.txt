cmake_minimum_required(VERSION 2.8)
project(embed-dart-vm-ng)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)

set(CMAKE_CXX_FLAGS "-Wall -Werror")
set(CMAKE_CXX_FLAGS_DEBUG "-DDEBUG -g")
set(CMAKE_CXX_FLAGS_RELEASE "-DNDEBUG -Os")
set(DART_SDK_ROOT ~/Development/google/dart/build/dart-sdk/sdk)

# needed for dart_vm_gen
include_directories(${DART_SDK_ROOT}/runtime)
include_directories(${DART_SDK_ROOT}/runtime/include)
include_directories(${DART_SDK_ROOT}/runtime/bin)

add_library(embed_dart_vm
    src/embeddedvm.cpp)

add_executable(embed-dart-vm_a main.cpp)
target_link_libraries(embed-dart-vm_a
    embed_dart_)