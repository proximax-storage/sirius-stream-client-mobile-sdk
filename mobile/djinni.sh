#! /usr/bin/env bash

### Configuration

# Djinni IDL file location
djinni_file="djinni/main.djinni"

# C++ namespace for generated src
namespace="clientsdk"

# Objective-C class name prefix for generated src
objc_prefix="PSP"

# Java package name for generated src
java_package="com.peerstream.psp.sdk.bridge"


### Script

# get base directory
base_dir=$(cd "`dirname "0"`" && pwd)

# get java directory from package name
java_dir=$(echo $java_package | tr . /)

# output directories for generated src
cpp_out="$base_dir/generated-src/cpp/clientsdk"
objc_out="$base_dir/generated-src/objc"
jni_out="$base_dir/generated-src/jni"
java_out="$base_dir/generated-src/java/$java_dir"

# clean generated src dirs
rm -rf $cpp_out
rm -rf $jni_out
rm -rf $objc_out
rm -rf $java_out

# execute the djinni command
deps/djinni/src/run \
   --java-out $java_out \
   --java-package $java_package \
   --ident-java-field mFooBar \
   --cpp-out $cpp_out \
   --cpp-namespace $namespace \
   --jni-out $jni_out \
   --ident-jni-class NativeFooBar \
   --ident-jni-file NativeFooBar \
   --objc-out $objc_out \
   --objc-type-prefix $objc_prefix \
   --objcpp-out $objc_out \
   --idl $djinni_file \
   --java-implement-android-os-parcelable true


# ******* CUSTOMIZED FOR CLIENT SDK ********
# need to update few djinni ObjC files to bracket-include dependencies
echo "Modifying Djinni ObjC generated files to <> include..."
find $objc_out -type f -print0 | xargs -0 sed -i '' 's/"ClientApp\.hpp"/<clientsdk\/ClientApp\.hpp>/g'
find $objc_out -type f -print0 | xargs -0 sed -i '' 's/"Channel\.hpp"/<clientsdk\/Channel\.hpp>/g'
find $objc_out -type f -print0 | xargs -0 sed -i '' 's/"Stream\.hpp"/<clientsdk\/Stream\.hpp>/g'

