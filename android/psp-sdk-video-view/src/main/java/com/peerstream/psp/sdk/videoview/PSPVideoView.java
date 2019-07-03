package com.peerstream.psp.sdk.videoview;

import android.content.Context;
import android.graphics.Bitmap;
import android.util.AttributeSet;
import android.widget.ImageView;

import androidx.appcompat.widget.AppCompatImageView;

import com.peerstream.psp.sdk.util.LogUtil;
import com.peerstream.psp.sdk.util.YUVtoRBG;
import com.peerstream.psp.sdk.videoview.util.UIThreadExecutor;
import com.peerstream.psp.sdk.videoview.util.VideoViewUIFactory;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Executor;

import static com.peerstream.psp.sdk.videoview.VideoScaleBehavior.FILL;
import static com.peerstream.psp.sdk.videoview.VideoScaleBehavior.FIT;

public class PSPVideoView extends AppCompatImageView {

    private VideoScaleBehavior mVideoScaleBehavior = null;

    private Bitmap mFrameBitmap = null;
    private int mFrameBitmapWidth = 0;
    private int mFrameBitmapHeight = 0;
    protected Executor mUIThreadExecutor = null;
    private YUVtoRBG mYUVConverter = null;

    private static Map<String, PSPVideoView> ACTIVE_VIDEO_VIEWS = new HashMap<>();

    public PSPVideoView(Context context) {
        super(context);

        init(context);
    }

    public PSPVideoView(Context context, AttributeSet attrs) {
        super(context, attrs);

        init(context);
    }

    public PSPVideoView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);

        init(context);
    }

    private void init(Context context) {
        mUIThreadExecutor = new UIThreadExecutor();
        mYUVConverter = new YUVtoRBG(context);
    }

    /**
     * Returns the current video scale mode assoiciated with this video view.
     * @return The current video scale mode.
     */
    public VideoScaleBehavior getVideoScaleBehavior() {
        return mVideoScaleBehavior;
    }

    /**
     * Sets the video scale mode for this video view.
     * @param videoScaleBehavior The new video scale mode.
     */
    public void setVideoScaleBehavior(VideoScaleBehavior videoScaleBehavior) {
        mVideoScaleBehavior = videoScaleBehavior;

        switch (mVideoScaleBehavior) {
            case FIT:
                setScaleType(ImageView.ScaleType.FIT_CENTER);
                break;
            case FILL:
                setScaleType(ImageView.ScaleType.CENTER_CROP);
                break;
        }
    }

    public void toggleVideoScaleBehavior() {
        VideoScaleBehavior next = (mVideoScaleBehavior == FILL) ? FIT : FILL;
        setVideoScaleBehavior(next);
    }

    public void setStreamId(String streamId) {
        ACTIVE_VIDEO_VIEWS.put(streamId, this);
    }

    public static void onVideoFrame(String streamId, byte[] buffer, int width, int height) {
        PSPVideoView videoView = ACTIVE_VIDEO_VIEWS.get(streamId);
        if (videoView != null) {
            videoView.onVideoFrame(buffer, width, height);
        }
    }

    public void onVideoFrame(byte[] buffer, int width, int height) {
        // If we don't have one yet, or if there is a resolution change, create the bitmap.
        if (mFrameBitmap == null || (width != mFrameBitmapWidth || height != mFrameBitmapHeight)) {
            LogUtil.info("Creating bitmap " + width + "x" + height);
            mFrameBitmap = VideoViewUIFactory.createBitmap(width, height);
            mFrameBitmapWidth = width;
            mFrameBitmapHeight = height;
        }

        // Update the bitmap with the new frame data.
        mYUVConverter.fillBitmap(buffer, width, height, mFrameBitmap);
        setBitmap(mFrameBitmap);
    }

    public void setBitmap(final Bitmap bitmap) {
        // Must run on UI thread.
        mUIThreadExecutor.execute(() -> {
            setImageBitmap(bitmap);
        });
    }

    public static void clear(String streamId) {
        PSPVideoView videoView = ACTIVE_VIDEO_VIEWS.get(streamId);
        if (videoView != null) {
            videoView.clear();
        }
    }

    public void clear() {
        // Must run on UI thread.
        mUIThreadExecutor.execute(() -> {
            setImageResource(android.R.color.transparent);
        });
    }
}
