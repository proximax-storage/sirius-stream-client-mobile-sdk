#!/bin/bash

MIDDLEWARE_DIR="deps/middleware"

target=
platform=
version_hash=
lib_build_type="release"

LIB_DIR_ROOT_URL="https://jfrog.theirweb.net:443/artifactory/psp-client-sdk-dev/"


usage() {
    echo "Usage: copy_middleware_libs [[ -t|--target (ios|macos|android) ] [ -v|--version VERSION_HASH ] [ -d|--debug ] | [ -h|--help ]]"
}

process() {
	HEADERS_INCLUDE="headers/middleware"
	LIBS_BIN="libs/${target}/bin"

	# clean old
	rm -rf libs/$target


	if [ -z $version_hash ]; then
		current_hash=$(grep MIDDLEWARE_VERSION_HASH headers/middleware/Version.hpp | cut -d ' ' -f 3 | cut -d '"' -f 2)

		echo "** Version parameter not found **  Defaulting to existing hash: ${current_hash}"
		version_hash=$current_hash
	fi


	if [[ $target = "ios" ]]; then
		echo "Creating bin subdirectory: ${LIBS_BIN}"
		mkdir -p $LIBS_BIN

		pushd $LIBS_BIN

		SIM_URL="${LIB_DIR_ROOT_URL}/${version_hash}/ios/${lib_build_type}/x86_64/libCoreSDK.dylib"
		if curl --output /dev/null --silent --head --fail "$SIM_URL"; then
			echo "Simulator .dylib URL exists, fetching."
			curl -o libCoreSDK_sim.dylib $SIM_URL
		fi

		DEV_URL="${LIB_DIR_ROOT_URL}/${version_hash}/ios/${lib_build_type}/arm64/libCoreSDK.dylib"
		if curl --output /dev/null --silent --head --fail "$DEV_URL"; then
			echo "Device .dylib URL exists, fetching."
			curl -o libCoreSDK_device.dylib $DEV_URL

			# check if both libs exist before we lipo together
			if [[ -f "libCoreSDK_sim.dylib" ]]; then
				echo "Simulator .dylib exists, running lipo to combine sim and device libs..."
				lipo libCoreSDK_sim.dylib libCoreSDK_device.dylib -output libCoreSDK.dylib -create
				rm -f libCoreSDK_sim.dylib
				rm -f libCoreSDK_device.dylib
			else
				echo "Simulator .dylib does not exist, renaming device lib..."
				mv libCoreSDK_device.dylib libCoreSDK.dylib
			fi
		fi

		popd
	elif [[ $target = "macos" ]]; then
		echo "Creating bin subdirectory: ${LIBS_BIN}"
		mkdir -p $LIBS_BIN

		pushd $LIBS_BIN
		curl -O "${LIB_DIR_ROOT_URL}/${version_hash}/osx/${lib_build_type}/libCoreSDK.dylib"
		curl -O "${LIB_DIR_ROOT_URL}/${version_hash}/osx/${lib_build_type}/h264lib_opencore.dylib"
		curl -O "${LIB_DIR_ROOT_URL}/${version_hash}/osx/${lib_build_type}/h264lib_x264.dylib"
		curl -O "${LIB_DIR_ROOT_URL}/${version_hash}/osx/${lib_build_type}/libwebrtc_shared.dylib"
		curl -O "${LIB_DIR_ROOT_URL}/${version_hash}/osx/${lib_build_type}/libx264.155.dylib"
		curl -O "${LIB_DIR_ROOT_URL}/${version_hash}/osx/${lib_build_type}/spexproj.dylib"
		popd
	elif [[ $target = "android" ]]; then
		echo "Creating bin subdirectory: ${LIBS_BIN}"
		mkdir -p $LIBS_BIN

		pushd $LIBS_BIN
		android_ver="16"
		curl -O "${LIB_DIR_ROOT_URL}/${version_hash}/android/${lib_build_type}/armeabi-v7a/${android_ver}/libCoreSDK.so"
		popd
	else
		echo "Failed to parse target (-t | --target). Must match either of these: (ios|macos|android)."
		exit 2
	fi


	# we only do these steps if current hash doesn't exist (update required):
	if [ -z $current_hash ]; then
		echo "Updating middleware submodule to current hash: ${version_hash}"
		pushd $MIDDLEWARE_DIR
		git checkout $version_hash
		popd

		echo "Creating header subdirectory: ${HEADERS_INCLUDE}"
		mkdir -p $HEADERS_INCLUDE

		echo "Copying headers..."
		cp $MIDDLEWARE_DIR/sdk/include/client/*.hpp $HEADERS_INCLUDE

		echo "Generating version hash: ${version_hash}"
		echo -e "\n#define MIDDLEWARE_VERSION_HASH \"${version_hash}\"" > $HEADERS_INCLUDE/Version.hpp
	fi
}


while [ "$1" != "" ]; do
	case $1 in
		-v | --version )	shift
							version_hash=$1
							;;
		-t | --target )		shift
							target=$1
							;;
		-d | --debug )		lib_build_type="debug"
							;;
		-h | --help )		usage
							exit
							;;
		* )					usage
							exit 1
	esac
	shift
done

process
