# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.4.1)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++17")

# Remove addition of c++11 by toolchain
string(REPLACE " -std=gnu++14" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
string(REPLACE " -std=c++11" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")

link_directories(${PROJECT_SOURCE_DIR}/src/main/jniLibs/${ANDROID_ABI})

file(GLOB psp_sdk_sources
    ./bridge/djinni/support-lib/jni/*.cpp
    ./bridge/generated/jni/*.cpp
    ./bridge/src/cpp/*.cpp
)

add_library(pspsdk SHARED ${psp_sdk_sources})

# include directories for header files
include_directories(
    ./bridge/djinni/support-lib/
    ./bridge/djinni/support-lib/jni/
    ./bridge/generated/cpp/
    ./bridge/generated/cpp/clientsdk
    ./bridge/generated/jni/
    ./bridge/libs/include/middleware
    ./bridge/src/cpp/
    ./bridge/src/cpp/clientsdk
)

find_library( # Sets the name of the path variable.
        log-lib

        # Specifies the name of the NDK library that
        # you want CMake to locate.
        log )

target_link_libraries(pspsdk
                    ${PROJECT_SOURCE_DIR}/src/main/jniLibs/${ANDROID_ABI}/libjingle_peerconnection_so.so
                    ${PROJECT_SOURCE_DIR}/src/main/jniLibs/${ANDROID_ABI}/libCoreSDK.so
                    ${log-lib}
        )
