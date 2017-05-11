
# Change the paths below to point to your Dart sdk build
cc_library(
	name="dartsdk",
	hdrs=glob["~/Development/google/dart/build/dart-sdk/sdk/runtime/include/*.h",
	"~/Development/google/dart/build/dart-sdk/sdk/runtime/bin/*.h"]
)

cc_library(
	name="embeddedvm",
	srcs=["embeddedvm.cpp"],
	hdrs=["embeddedvm.h"],
	deps=["//dartsdk"],
	visibility=["//:__pkg__"],

)