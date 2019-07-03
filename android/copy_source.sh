#!/bin/bash

SRC_DIR="mobile/src"
LIB_HEADER_DIR="mobile/libs/ios/include/middleware"
LIB_DIR_URL="https://jfrog.theirweb.net:443/artifactory/psp-client-sdk-dev/android/release"
DJINNI_SRC_DIR="mobile/djinni-src"
GENERATED_SRC_DIR="mobile/generated-src"


PROJ_DEST_DIR="psp-sdk"

DEST_SRC_DIR="${PROJ_DEST_DIR}/bridge/src"
DEST_LIB_DIR="${PROJ_DEST_DIR}/bridge/libs"
DEST_DJINNI_SRC_DIR="${PROJ_DEST_DIR}/bridge/djinni-src"
DEST_GENERATED_SRC_DIR="${PROJ_DEST_DIR}/bridge/generated-src"
mkdir -p $DEST_SRC_DIR
mkdir -p $DEST_LIB_DIR
mkdir -p $DEST_DJINNI_SRC_DIR
mkdir -p $DEST_GENERATED_SRC_DIR

# sources
echo "Copying sources..."
cp -r $SRC_DIR/cpp $DEST_SRC_DIR
cp -r $SRC_DIR/java $DEST_SRC_DIR


# djinni setup files
echo "Copying djinni setup header files..."
for file in "${DJINNI_SRC_DIR}/*.hpp"
do
    cp -f $file "${DEST_DJINNI_SRC_DIR}"
done

echo "Copying djinni Java setup files..."
cp -r "${DJINNI_SRC_DIR}/java" "${DEST_DJINNI_SRC_DIR}"


# djinni c++ header files
DEST_GEN_CPP_DIR="${DEST_SRC_DIR}/cpp/clientsdk"
mkdir -p $DEST_GEN_CPP_DIR
echo "Copying djinni C++ wrapper files..."
find "${GENERATED_SRC_DIR}/cpp" -type f -name '*.hpp' -exec cp -f '{}' "${DEST_GEN_CPP_DIR}" ';'


# djinni Java wrapper files
GEN_JAVA_DIR="${DEST_GENERATED_SRC_DIR}/java"
mkdir -p "${GEN_JAVA_DIR}"

echo "Copying and sorting djinni Java wrapper files..."
for file in $GENERATED_SRC_DIR/java/*; do
        echo "Copying file from generated dir: ${file}"
        cp -rf $file "${GEN_JAVA_DIR}"
done

# djinni JNI wrapper files
GEN_JNI_DIR="${DEST_GENERATED_SRC_DIR}/jni"
mkdir -p "${GEN_JNI_DIR}"

echo "Copying and sorting djinni JNI wrapper files..."
for file in $GENERATED_SRC_DIR/jni/*; do
        echo "Copying file from generated dir: ${file}"
        cp -rf $file "${GEN_JNI_DIR}"
done


# libs and headers
echo "Copying lib headers..."
mkdir -p  $DEST_LIB_DIR/include
cp -r $LIB_HEADER_DIR $DEST_LIB_DIR/include

#echo "Copying libs..."
#mkdir -p  $DEST_LIB_DIR/bin
#pushd $DEST_LIB_DIR/bin
#curl -O "${LIB_DIR_URL}/libboost.a"
#curl -O "${LIB_DIR_URL}/libClientLib.a"
#curl -O "${LIB_DIR_URL}/libCoreLib.a"
#curl -O "${LIB_DIR_URL}/libcrypto.a"
#curl -O "${LIB_DIR_URL}/libCryptoLib.a"
#curl -O "${LIB_DIR_URL}/libNetioLib.a"
#curl -O "${LIB_DIR_URL}/libRoutingLib.a"
#curl -O "${LIB_DIR_URL}/libsodium.a"
#curl -O "${LIB_DIR_URL}/libssl.a"
#popd
