//
//  VideoStreamerInternal.hpp
//  PSPClient
//
//  Created by Bastek on 4/24/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#pragma once

#include <clientsdk/VideoStreamer.hpp>
#include <clientsdk/VideoStreamOptions.hpp>
#include <clientsdk/VideoStreamerObserver.hpp>
#include <clientsdk/VideoStreamBroadcastRetrieverHandler.hpp>
#include <clientsdk/VideoStreamRequestHandler.hpp>
#include <clientsdk/VideoStreamErrorId.hpp>
#include <clientsdk/VideoStreamDevice.hpp>
#include <clientsdk/VideoStreamCapability.hpp>

#include <middleware/IVideoStreamer.hpp>

#include <iostream>


namespace clientsdk {

    using namespace peerstream::client;


    class VideoStreamerInternal: public clientsdk::VideoStreamer {

    private:
        using ConnectionPtr = peerstream::core::signals::ConnectionPtr;
        using ConnectionPtrList = peerstream::core::signals::ConnectionPtrList;

        using VideoStreamID = IVideoStreamer::VideoStreamID;
        using SharedConstBuffer = IVideoStreamer::SharedConstBuffer;
        using VideoStreamErrorID = peerstream::client::VideoStreamErrorID;
        using FrameOrientation = peerstream::client::VideoFrameOrientation;
        using VideoDevice = peerstream::client::VideoDevice;
        using VideoCapability = peerstream::client::VideoCapability;

        using OnRetrieveBroadcastVideoStream = IVideoStreamer::OnRetrieveBroadcastVideoStream;
        using OnDisplayFrameReceived = IVideoStreamer::OnDisplayFrameReceived;
        using OnVideoStreamDestroyed = IVideoStreamer::OnVideoStreamDestroyed;

        IVideoStreamer &m_vidStreamer;
        std::shared_ptr<VideoStreamerObserver> m_observer;

        ConnectionPtrList connections_;

        FrameOrientation mapOrientation(VideoFrameOrientation val);
        VideoFrameOrientation mapOrientation(FrameOrientation val);

        // video mapping
        VideoStreamDevice mapVideoDevice(VideoDevice val);
        VideoStreamCapability mapVideoCapability(VideoCapability val);

        void onDisplayFrameReceived(VideoStreamID streamId,
                                    SharedConstBuffer buffer,
                                    int32_t width,
                                    int32_t height,
                                    FrameOrientation orientation);

        void onVideoStreamDestroyed(VideoStreamID streamId);

    public:
        // setup and teardown
        VideoStreamerInternal(IVideoStreamer &vidStreamer)
        : m_vidStreamer(vidStreamer) {
            std::cout << "<<< INITIALIZING VID STREAMER..." << std::endl;
        };
        ~VideoStreamerInternal() {};

        void initialize(const VideoStreamOptions &options,
                        const std::shared_ptr<VideoStreamerObserver> &observer);

        void startStreaming(const std::shared_ptr<VideoStreamRequestHandler> &handler);
        void stopStreaming();

        void startViewing(const std::string &streamId,
                          const std::shared_ptr<VideoStreamRequestHandler> &handler);
        void stopViewing(const std::string &streamId);

        void enableAudioCapture(bool isEnabled);
        void enableVideoCapture(bool isEnabled);

        void setMicrophoneVolume(int32_t val);
        void setSpeakerVolume(int32_t val);

        void setAudioInputDevice(int32_t index);
        void setAudioOutputDevice(int32_t index);
        void setVideoDevice(int32_t index);
        void setVideoCapability(int32_t index);

        int32_t selectedAudioInputDevice();
        int32_t selectedAudioOutputDevice();
        int32_t selectedVideoDevice();
        int32_t selectedVideoCapability();

        std::vector<std::string> getAudioInputDevices();
        std::vector<std::string> getAudioOutputDevices();
        std::vector<VideoStreamDevice> getVideoDevices();
        std::vector<VideoStreamCapability> getVideoCapabilities(int32_t index);

        void retrieveBroadcastStreamId(const std::shared_ptr<VideoStreamBroadcastRetrieverHandler> &handler);

    };

} // namespace clientsdk
