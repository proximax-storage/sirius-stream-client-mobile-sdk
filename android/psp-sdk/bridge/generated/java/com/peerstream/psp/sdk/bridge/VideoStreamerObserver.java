// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from VideoStreamer.djinni

package com.peerstream.psp.sdk.bridge;

public abstract class VideoStreamerObserver {
    public abstract void onVideoStreamDisplayFrameReceived(String streamId, byte[] buffer, int width, int height, VideoFrameOrientation orientation);

    public abstract void onVideoStreamDestroyed(String streamId);
}
