#!/bin/bash

JNI_LIBS_DIR="./psp-sdk/src/main/jniLibs"
JNI_ARM_DIR="$JNI_LIBS_DIR/armeabi-v7a"

ARTIFACTORY_URL="https://jfrog.theirweb.net/artifactory/psp-client-sdk-dev/android/release"

LIBS=(
"armeabi-v7a/libCoreSDK.so"
)

echo $JNI_LIBS_DIR
echo $JNI_ARM_DIR

mkdir -p $JNI_ARM_DIR

for var in "${LIBS[@]}"
do
  echo "Updating lib: ${var}"
  (cd $JNI_ARM_DIR && curl -O $ARTIFACTORY_URL/${var})
done