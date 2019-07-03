package com.peerstream.psp.sdk.videoview;

/**
 * The video view scale modes supported by {@link #PSPVideoView() PSPVideoView}.
 */
public enum VideoScaleBehavior {
    /**
     * Will show the entire, uncropped video feed image, scaled within the confines of the view as positioned in
     * the screen's layout. There will typically be black, empty bars visible on either the top and bottom, or left
     * and right of the video feed image.
     */
    FIT,
    /**
     * Will scale up and crop the video feed image, so that no portions of the view as positioned in the screen's layout
     * appears as black, empty bars.
     */
    FILL
}

