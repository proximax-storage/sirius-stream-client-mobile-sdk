// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from VideoStreamer.djinni

#pragma once

#include <optional>
#include <string>

namespace clientsdk {

class VideoStreamBroadcastRetrieverHandler {
public:
    virtual ~VideoStreamBroadcastRetrieverHandler() {}

    virtual void onRetrieveBroadcastStreamId(const std::optional<std::string> & streamId) = 0;
};

}  // namespace clientsdk
