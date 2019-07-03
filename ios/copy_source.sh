#!/bin/bash

SRC_DIR="mobile/src"
LIB_BIN_DIR="mobile/libs/ios/bin"
LIB_HEADER_DIR="mobile/headers/middleware"
DJINNI_SRC_DIR="mobile/djinni-src"
GENERATED_SRC_DIR="mobile/generated-src"


PROJ_DEST_DIR="PSPClientKit/bridge"

# clean old bridge dir
rm -rf $PROJ_DEST_DIR

DEST_SRC_DIR="${PROJ_DEST_DIR}/src"
DEST_LIB_DIR="${PROJ_DEST_DIR}/libs"
DEST_DJINNI_SRC_DIR="${PROJ_DEST_DIR}/djinni-src"
DEST_GENERATED_SRC_DIR="${PROJ_DEST_DIR}/generated-src"
mkdir -p $DEST_SRC_DIR
mkdir -p $DEST_LIB_DIR
mkdir -p $DEST_DJINNI_SRC_DIR
mkdir -p $DEST_GENERATED_SRC_DIR

# sources
echo "Copying sources..."
cp -r $SRC_DIR/cpp $DEST_SRC_DIR
cp -r $SRC_DIR/objc $DEST_SRC_DIR


# djinni setup files
echo "Copying djinni setup header files..."
for file in "${DJINNI_SRC_DIR}/*.hpp"
do
    cp -f $file "${DEST_DJINNI_SRC_DIR}"
done

echo "Copying djinni ObjC setup files..."
cp -r "${DJINNI_SRC_DIR}/objc" "${DEST_DJINNI_SRC_DIR}"


# djinni c++ header files
DEST_GEN_CPP_DIR="${DEST_GENERATED_SRC_DIR}/cpp/clientsdk"
mkdir -p $DEST_GEN_CPP_DIR
echo "Copying djinni C++ wrapper files..."
find "${GENERATED_SRC_DIR}/cpp" -type f -name '*.hpp' -exec cp -f '{}' "${DEST_GEN_CPP_DIR}" ';'


# djinni ObjC wrapper files
GEN_OBJC_DIR="${DEST_GENERATED_SRC_DIR}/objc"
mkdir -p "${GEN_OBJC_DIR}/private"
filePrivateRegex=".*Private.(h|m{1,2})"

echo "Copying and sorting djinni ObjC wrapper files..."
for file in $GENERATED_SRC_DIR/objc/*; do
    if [[ $file =~ $filePrivateRegex ]]; then
        echo "Copying PRIVATE file from generated dir: ${file}"
        cp -f $file "${GEN_OBJC_DIR}/private"
    else
        echo "Copying file from generated dir: ${file}"
        cp -f $file "${GEN_OBJC_DIR}"
    fi
done


# libs and headers
echo "Copying lib headers..."
mkdir -p  $DEST_LIB_DIR/include
cp -r $LIB_HEADER_DIR $DEST_LIB_DIR/include

echo "Copying libs..."
cp -r $LIB_BIN_DIR $DEST_LIB_DIR/bin
