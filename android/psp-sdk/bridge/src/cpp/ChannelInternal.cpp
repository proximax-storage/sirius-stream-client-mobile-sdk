
#include "ChannelInternal.hpp"


namespace clientsdk {

    static constexpr const auto _1 = std::placeholders::_1;


    void ChannelInternal::setObserver(const std::shared_ptr<ChannelObserver> & observer) {
        using namespace std;

        if (observer && observer!=m_observer) {
            connections_.push_back(m_channel->registerMessageReceived(bind(&ChannelInternal::onMessageReceived, this, _1)));
            connections_.push_back(m_channel->registerRawDataReceived(bind(&ChannelInternal::onRawDataReceived, this, _1)));
            connections_.push_back(m_channel->registerChannelError(bind(&ChannelInternal::onChannelError, this, _1)));
            connections_.push_back(m_channel->registerVideoStreamRequested(bind(&ChannelInternal::onStreamRequested, this)));
            connections_.push_back(m_channel->registerVideoStreamShared(bind(&ChannelInternal::onStreamShared, this, _1)));
        } else {
            connections_.clear();
        }

        m_observer = observer;
    }

    void ChannelInternal::sendRawData(const std::vector<uint8_t> &data) {
        if (m_channel) {
            m_channel->sendRawData(data);
        }
    }

    void ChannelInternal::sendMessage(const std::string &msg) {
        if (m_channel) {
            m_channel->sendMessage(msg);
        }
    }

    void ChannelInternal::close() {
        if (m_channel) {
            m_channel->closeChannel();

            connections_.clear();
            m_observer = nullptr;
        }
    }

    void ChannelInternal::shareStream(const std::shared_ptr<ChannelStreamHandler> &handler)
    {
        if (m_channel) {
            m_channel->shareStream([this, handler] (const std::string &streamId) -> void {
                if (handler) {
                    handler->onStreamCreated(getIdentity(), streamId);
                }
            }, [this, handler] (VideoStreamErrorID eid) -> void {
                if (handler) {
                    VideoStreamErrorId errorId = VideoStreamErrorId(eid);
                    handler->onStreamError(getIdentity(), errorId);
                }
            });
        }
    }

    void ChannelInternal::requestStream(const std::shared_ptr<ChannelStreamHandler> &handler) {
        if (m_channel) {
            m_channel->requestStream([this, handler] (const std::string & streamId) -> void {
                if (handler) {
                    handler->onStreamCreated(getIdentity(), streamId);
                }
            }, [this, handler] (VideoStreamErrorID eid) -> void {
                if (handler) {
                    VideoStreamErrorId errorId = VideoStreamErrorId(eid);
                    handler->onStreamError(getIdentity(), errorId);
                }
            });
        }
    }

    void ChannelInternal::confirmVideoStreamRequest(const std::shared_ptr<ChannelStreamHandler> &handler) {
        if (m_channel) {
            m_channel->confirmVideoStreamRequest([this, handler] (const std::string & streamId) -> void {
                if (handler) {
                    handler->onStreamCreated(getIdentity(), streamId);
                }
            }, [this, handler] (VideoStreamErrorID eid) -> void {
                if (handler) {
                    VideoStreamErrorId errorId = VideoStreamErrorId(eid);
                    handler->onStreamError(getIdentity(), errorId);
                }
            });
        }
    }

    void ChannelInternal::denyVideoStreamRequest() {
        if (m_channel) {
            m_channel->denyVideoStreamRequest();
        }
    }

    void ChannelInternal::confirmVideoStreamShare(const std::shared_ptr<ChannelStreamHandler> &handler) {
        if (m_channel) {
            m_channel->confirmVideoStreamShare([this, handler] (const std::string & streamId) -> void {
                if (handler) {
                    handler->onStreamCreated(getIdentity(), streamId);
                }
            }, [this, handler] (VideoStreamErrorID eid) -> void {
                if (handler) {
                    VideoStreamErrorId errorId = VideoStreamErrorId(eid);
                    handler->onStreamError(getIdentity(), errorId);
                }
            });
        }
    }

    void ChannelInternal::denyVideoStreamShare() {
        if (m_channel) {
            m_channel->denyVideoStreamShare();
        }
    }

    void ChannelInternal::stopViewingStream() {
        if (m_channel) {
            m_channel->stopViewingStream();
        }
    }

    bool ChannelInternal::isConfirmed() {
        if (m_channel) {
            return m_channel->isConfirmed();
        }
        return false;
    }

    std::string ChannelInternal::getIdentity() {
        if (m_channel) {
            return m_channel->identity();
        }
        return "";
    }

    /*
     * Callbacks
     */
    void ChannelInternal::onMessageReceived(const std::string &message) {
        if (m_observer) {
            m_observer->onMessageReceived(getIdentity(), message);
        }
    }

    void ChannelInternal::onRawDataReceived(const std::vector<uint8_t> &rawData) {
        if (m_observer) {
            m_observer->onRawReceived(getIdentity(), rawData);
        }
    }

    void ChannelInternal::onChannelError(const ChannelErrorID &errorId) {
        if (m_observer) {
            ChannelErrorId eid = ChannelErrorId(errorId);
            m_observer->onChannelError(getIdentity(), eid);
        }
    }

    void ChannelInternal::onStreamRequested() {
        if (m_observer) {
            m_observer->onStreamRequested(getIdentity());
        }
    }

    void ChannelInternal::onStreamShared(const std::string &streamId) {
        if (m_observer) {
            m_observer->onStreamShared(getIdentity(), streamId);
        }
    }
}
