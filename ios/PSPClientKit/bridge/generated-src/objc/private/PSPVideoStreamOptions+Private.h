// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from VideoStreamer.djinni

#import "PSPVideoStreamOptions.h"
#include "VideoStreamOptions.hpp"

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

@class PSPVideoStreamOptions;

namespace djinni_generated {

struct VideoStreamOptions
{
    using CppType = ::clientsdk::VideoStreamOptions;
    using ObjcType = PSPVideoStreamOptions*;

    using Boxed = VideoStreamOptions;

    static CppType toCpp(ObjcType objc);
    static ObjcType fromCpp(const CppType& cpp);
};

}  // namespace djinni_generated
