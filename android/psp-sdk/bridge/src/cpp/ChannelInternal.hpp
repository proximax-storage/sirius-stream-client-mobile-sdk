#pragma once

#include <clientsdk/Channel.hpp>
#include <clientsdk/ChannelObserver.hpp>
#include <clientsdk/ChannelStreamHandler.hpp>

#include <IChannel.hpp>


namespace clientsdk {

    using namespace peerstream::client;


    class ChannelInternal: public clientsdk::Channel {

    private:
        using ConnectionPtr = peerstream::core::signals::ConnectionPtr;
        using ConnectionPtrList = peerstream::core::signals::ConnectionPtrList;

        using Image = peerstream::client::Image;
        using ChannelErrorID = peerstream::client::ChannelErrorID;
        using VideoStreamErrorID = peerstream::client::VideoStreamErrorID;

        using OnMessageReceived = IChannel::OnMessageReceived;
        using OnChannelError = IChannel::OnChannelError;

        using OnVideoStreamRequested = IChannel::OnVideoStreamRequested;
        using OnVideoStreamCreated = IChannel::OnVideoStreamCreated;
        using OnVideoStreamError = IChannel::OnVideoStreamError;


        std::shared_ptr<IChannel> m_channel;
        std::shared_ptr<ChannelObserver> m_observer;

        ConnectionPtrList connections_;
        bool hasRegisteredCallbacks;

        void onMessageReceived(const std::string &message);
        void onRawDataReceived(const std::vector<uint8_t> &rawData);
        void onImageReceived(const Image &image);
        void onChannelError(const ChannelErrorID &errorId);
        void onStreamRequested();
        void onStreamShared(const std::string &streamId);

    public:
        // setup and teardown
        ChannelInternal(const std::shared_ptr<IChannel> &channel) {
            m_channel = channel;
        };
        ~ChannelInternal() {};

        void setObserver(const std::shared_ptr<ChannelObserver> &observer);

        void sendRawData(const std::vector<uint8_t> &data);
        void sendMessage(const std::string &msg);
        void close();

        void shareStream(const std::shared_ptr<ChannelStreamHandler> &handler);
        void requestStream(const std::shared_ptr<ChannelStreamHandler> &handler);
        void confirmVideoStreamRequest(const std::shared_ptr<ChannelStreamHandler> &handler);
        void denyVideoStreamRequest();
        void confirmVideoStreamShare(const std::shared_ptr<ChannelStreamHandler> &handler);
        void denyVideoStreamShare();
        void stopViewingStream();

        bool isConfirmed();

        std::string getIdentity();
    };

}  // namespace clientsdk
