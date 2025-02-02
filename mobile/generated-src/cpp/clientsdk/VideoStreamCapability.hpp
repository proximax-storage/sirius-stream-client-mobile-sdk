// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from VideoStreamer.djinni

#pragma once

#include <cstdint>
#include <utility>

namespace clientsdk {

struct VideoStreamCapability final {
    int32_t width;
    int32_t height;
    int32_t maxFPS;
    bool isInterlaced;

    VideoStreamCapability(int32_t width_,
                          int32_t height_,
                          int32_t maxFPS_,
                          bool isInterlaced_)
    : width(std::move(width_))
    , height(std::move(height_))
    , maxFPS(std::move(maxFPS_))
    , isInterlaced(std::move(isInterlaced_))
    {}
};

}  // namespace clientsdk
