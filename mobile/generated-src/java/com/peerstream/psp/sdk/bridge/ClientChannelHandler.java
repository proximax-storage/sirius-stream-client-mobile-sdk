// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

package com.peerstream.psp.sdk.bridge;

public abstract class ClientChannelHandler {
    public abstract void onChannelConfirmed(String clientId, Channel channel);

    public abstract void onChannelResponseError(String clientId, ChannelRequestErrorId errorId);
}
