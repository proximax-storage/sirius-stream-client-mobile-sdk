// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from VideoStreamer.djinni

#pragma once

#include "VideoStreamCapability.hpp"
#include <string>
#include <utility>
#include <vector>

namespace clientsdk {

struct VideoStreamDevice final {
    std::string name;
    std::string identifier;
    std::vector<VideoStreamCapability> videoCapabilities;

    VideoStreamDevice(std::string name_,
                      std::string identifier_,
                      std::vector<VideoStreamCapability> videoCapabilities_)
    : name(std::move(name_))
    , identifier(std::move(identifier_))
    , videoCapabilities(std::move(videoCapabilities_))
    {}
};

}  // namespace clientsdk
