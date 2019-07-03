#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]
then
    echo "Usage: $0 <middleware-dir>"
    exit -1
fi

MIDDLEWARE_FOLDER="$1"
APP_DIR=psp-sdk

ARCH=armeabi-v7a
API_LEVEL=16
BUILD_TYPE=Debug
WEBRTC_BUILD_TYPE=Release

pushd $MIDDLEWARE_FOLDER

# Retrieve the name of the os platform
os=`uname`
platform='Unknown'

if [[ $os == "Darwin" ]]
then
	platform="osx"
elif [[ $os == "Linux" ]]
then
	platform="lin"
elif [[ $os == "Windows" ]]
then
	platform="win"
fi

OUT_DIR=bin/${BUILD_TYPE}.${platform}.Android.${ARCH}.${API_LEVEL}

if [[ ${ARCH} == "armeabi-v7a" ]]
then
    ARCH_SHORT=arm
elif [[ ${ARCH} == "arm64-v8a" ]]
then
    ARCH_SHORT=arm64
else
    ARCH_SHORT=${ARCH}
fi

./build.sh --api ${API_LEVEL} -a ${ARCH} -p Android ${BUILD_TYPE} SDL2 hidapi SDL2_ttf CoreSDK  Middleware;

popd

rm -rf ${APP_DIR}/libs/*.jar
rm -rf ${APP_DIR}/libs/*.so
rm -rf ${APP_DIR}/src/main/jniLibs/${ARCH}/*.jar
rm -rf ${APP_DIR}/src/main/jniLibs/${ARCH}/*.so

jni_libs=(\
    ${MIDDLEWARE_FOLDER}/${OUT_DIR}/lib/libCoreSDK.so\
    ${MIDDLEWARE_FOLDER}/3rdParty/webrtc/android/${ARCH_SHORT}/${WEBRTC_BUILD_TYPE}/libjingle_peerconnection_so.so\
)

for lib in ${jni_libs[@]}
do
    echo "Copying ${lib} to ${APP_DIR}/src/main/jniLibs/${ARCH}/"
    cp -p ${lib} ${APP_DIR}/src/main/jniLibs/${ARCH}/
done

jars=(\
    ${MIDDLEWARE_FOLDER}/3rdParty/webrtc/android/${ARCH_SHORT}/${WEBRTC_BUILD_TYPE}/libwebrtc.jar\
)

for lib in ${jars[@]}
do
    echo "Copying ${lib} to ${APP_DIR}/libs/"
    cp -p ${lib} ${APP_DIR}/libs/
done

