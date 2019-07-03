//
//  VideoStreamerInternal.cpp
//  PSPClient
//
//  Created by Bastek on 4/24/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#include "VideoStreamerInternal.hpp"

#include <functional>
#include <iostream>
#include <optional>


namespace clientsdk {

    using namespace std;
    using FrameOrientation = peerstream::client::VideoFrameOrientation;


    void VideoStreamerInternal::initialize(const VideoStreamOptions &options,
                                           const std::shared_ptr<VideoStreamerObserver> &observer)
    {
        using namespace std::placeholders;

        connections_.clear();

        StreamingOptions param {
            .audioCaptureEnabled = options.audioCaptureEnabled,
            .initialSpeakerVolume = options.initialSpeakerVolume,
            .initialMicVolume = options.initialMicVolume,
            .videoCaptureEnabled = options.videoCaptureEnabled,
            .streamingWidth = options.streamingWidth,
            .streamingHeight = options.streamingHeight,
            .orientation = mapOrientation(options.orientation),
        };
        m_vidStreamer.initialize(param);


        if (observer) {
            m_observer = observer;

            connections_.push_back(
                m_vidStreamer.registerDisplayFrameReceived(
                    bind(&VideoStreamerInternal::onDisplayFrameReceived,
                         this,
                         _1,
                         _2,
                         _3,
                         _4,
                         _5
                    )
                )
            );
            connections_.push_back(
                m_vidStreamer.registerVideoStreamDestroyed(
                   bind(&VideoStreamerInternal::onVideoStreamDestroyed, this, _1)
                )
            );
        }
    }


    FrameOrientation VideoStreamerInternal::mapOrientation(VideoFrameOrientation val) {
        switch(val) {
            case VideoFrameOrientation::ROTATE270:
                return FrameOrientation::rotate270;
            case VideoFrameOrientation::ROTATE180:
                return FrameOrientation::rotate180;
            case VideoFrameOrientation::ROTATE90:
                return FrameOrientation::rotate90;
            case VideoFrameOrientation::ROTATE0:
                return FrameOrientation::rotate0;
        }
    }


    VideoFrameOrientation VideoStreamerInternal::mapOrientation(FrameOrientation val) {
        switch(val) {
            case FrameOrientation::rotate270:
                return VideoFrameOrientation::ROTATE270;
            case FrameOrientation::rotate180:
                return VideoFrameOrientation::ROTATE180;
            case FrameOrientation::rotate90:
                return VideoFrameOrientation::ROTATE90;
            case FrameOrientation::rotate0:
                return VideoFrameOrientation::ROTATE0;
        }
    }


    VideoStreamDevice VideoStreamerInternal::mapVideoDevice(VideoDevice val) {
        auto capabilities = std::vector<VideoStreamCapability>();
        for(auto& capability : val.videoCapabilities) {
            capabilities.push_back(this->mapVideoCapability(capability));
        }

        VideoStreamDevice device = VideoStreamDevice(val.name,
                                                     val.id,
                                                     capabilities);
        return device;
    }


    VideoStreamCapability VideoStreamerInternal::mapVideoCapability(VideoCapability val) {
        return VideoStreamCapability(val.width,
                                     val.height,
                                     val.maxFPS,
                                     val.isInterlaced);
    }


    void VideoStreamerInternal::startStreaming(const std::shared_ptr<VideoStreamRequestHandler> &handler) {
        m_vidStreamer.startStreaming([handler] (const VideoStreamID &streamId) {
            if (handler) {
                handler->onVideoStreamStarted(std::move(streamId));
            }
        }, [handler] (VideoStreamErrorID eid) -> void {
            if (handler) {
                VideoStreamErrorId errorId = VideoStreamErrorId(eid);
                handler->onVideoStreamError(errorId);
            }
        });
    }


    void VideoStreamerInternal::stopStreaming() {
        m_vidStreamer.stopStreaming();
    }


    void VideoStreamerInternal::startViewing(const std::string &streamId,
                      const std::shared_ptr<VideoStreamRequestHandler> &handler)
    {
        m_vidStreamer.startViewing(streamId, [handler] (const VideoStreamID &streamId) {
            if (handler) {
                handler->onVideoStreamStarted(std::move(streamId));
            }
        }, [handler] (VideoStreamErrorID eid) {
            if (handler) {
                VideoStreamErrorId errorId = VideoStreamErrorId(eid);
                handler->onVideoStreamError(errorId);
            }
        });
    }


    void VideoStreamerInternal::stopViewing(const std::string &streamId) {
        m_vidStreamer.stopViewing(streamId);
    }


    void VideoStreamerInternal::enableAudioCapture(bool isEnabled) {
        m_vidStreamer.enableAudioCapture(isEnabled);
    }


    void VideoStreamerInternal::enableVideoCapture(bool isEnabled) {
        m_vidStreamer.enableVideoCapture(isEnabled);
    }


    void VideoStreamerInternal::setMicrophoneVolume(int32_t val) {
        m_vidStreamer.setMicrophoneVolume(val);
    }


    void VideoStreamerInternal::setSpeakerVolume(int32_t val) {
        m_vidStreamer.setSpeakerVolume(val);
    }


    void VideoStreamerInternal::setAudioInputDevice(int32_t index) {
        m_vidStreamer.setAudioInputDeviceID(index);
    }


    void VideoStreamerInternal::setAudioOutputDevice(int32_t index) {
        m_vidStreamer.setAudioOutputDeviceID(index);
    }


    void VideoStreamerInternal::setVideoDevice(int32_t index) {
        m_vidStreamer.setVideoDevice(index);
    }


    void VideoStreamerInternal::setVideoCapability(int32_t index) {
        m_vidStreamer.setVideoCapability(index);
    }


    int32_t VideoStreamerInternal::selectedAudioInputDevice() {
        return m_vidStreamer.selectedAudioInputDeviceID();
    }


    int32_t VideoStreamerInternal::selectedAudioOutputDevice() {
        return m_vidStreamer.selectedAudioOutputDeviceID();
    }


    int32_t VideoStreamerInternal::selectedVideoDevice() {
        return m_vidStreamer.selectedVideoDevice();
    }


    int32_t VideoStreamerInternal::selectedVideoCapability() {
        return m_vidStreamer.selectedVideoCapability();
    }


    std::vector<std::string> VideoStreamerInternal::getAudioInputDevices() {
        return m_vidStreamer.getAudioInputDevices();
    }


    std::vector<std::string> VideoStreamerInternal::getAudioOutputDevices() {
        return m_vidStreamer.getAudioOutputDevices();
    }


    std::vector<VideoStreamDevice> VideoStreamerInternal::getVideoDevices() {
        auto devices = std::vector<VideoStreamDevice>();
        for(auto& device : m_vidStreamer.getVideoDevices()) {
            devices.push_back(this->mapVideoDevice(device));
        }
        return devices;
    }


    std::vector<VideoStreamCapability> VideoStreamerInternal::getVideoCapabilities(int32_t index) {
        return std::vector<VideoStreamCapability>();
        //FIXME: convert //m_vidStreamer.getVideoCapabilities(index);
    }


    void VideoStreamerInternal::retrieveBroadcastStreamId(const std::shared_ptr<VideoStreamBroadcastRetrieverHandler> &handler)
    {
        m_vidStreamer.retrieveBroadcastVideoStreamID([handler] (const std::optional<VideoStreamID> &streamId)
        {
            if (handler) {
                handler->onRetrieveBroadcastStreamId(std::move(streamId));
            }
        });
    }


    /*
     * Registered callbacks
     */
    void VideoStreamerInternal::onDisplayFrameReceived(VideoStreamID streamId,
                                                       SharedConstBuffer buffer,
                                                       int32_t width,
                                                       int32_t height,
                                                       FrameOrientation orientation)
    {
        if (m_observer) {
            m_observer->onVideoStreamDisplayFrameReceived(move(streamId),
                                                          *buffer.get(),
                                                          width,
                                                          height,
                                                          mapOrientation(orientation));
        }
    }


    void VideoStreamerInternal::onVideoStreamDestroyed(VideoStreamID streamId) {
        if (m_observer) {
            m_observer->onVideoStreamDestroyed(streamId);
        }
    }
}
