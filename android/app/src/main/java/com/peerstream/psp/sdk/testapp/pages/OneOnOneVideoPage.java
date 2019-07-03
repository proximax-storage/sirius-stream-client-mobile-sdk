package com.peerstream.psp.sdk.testapp.pages;

import android.content.ComponentName;
import android.graphics.Color;
import android.os.Bundle;
import android.os.IBinder;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;

import com.peerstream.psp.sdk.bridge.VideoFrameOrientation;
import com.peerstream.psp.sdk.bridge.VideoStreamErrorId;
import com.peerstream.psp.sdk.bridge.VideoStreamOptions;
import com.peerstream.psp.sdk.bridge.VideoStreamRequestHandler;
import com.peerstream.psp.sdk.bridge.VideoStreamer;
import com.peerstream.psp.sdk.bridge.VideoStreamerObserver;
import com.peerstream.psp.sdk.testapp.R;
import com.peerstream.psp.sdk.testapp.utils.AppUtils;
import com.peerstream.psp.sdk.videoview.PSPVideoView;
import com.peerstream.psp.sdk.videoview.VideoScaleBehavior;

import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;
import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class OneOnOneVideoPage extends BasePage {

    private static final String TAG = OneOnOneVideoPage.class.getSimpleName();

    private ConstraintLayout mRootView = null;

    @BindView(R.id.frm_one_on_one_broadcaster) FrameLayout mFrameBroadcasterVideo;
    @BindView(R.id.frm_one_on_one_viewer) FrameLayout mFrameFriendVideo;
    @BindView(R.id.btn_one_on_one_broadcast) Button mStartBroadcasterButton;
    @BindView(R.id.btn_one_on_one_stop_broadcast) Button mStopBroadcasterButton;
    @BindView(R.id.btn_one_on_one_toggle_video) Button mToggleBroadcasterVideoButton;
    @BindView(R.id.btn_one_on_one_toggle_audio) Button mToggleBroadcasterAudioButton;
    @BindView(R.id.edit_one_on_one_stream_id) EditText mFriendStreamId;
    @BindView(R.id.btn_one_on_one_view) Button mStartViewerButton;
    @BindView(R.id.btn_one_on_one_stop_viewer) Button mStopViewerButton;

    PSPVideoView mVideoViewBroadcaster = null;
    PSPVideoView mVideoViewFriend = null;

    VideoStreamer mVideoStreamer = null;
    private boolean mActiveBroadcast = false;
    private boolean mBroadcasterVideoEnabled = true;
    private boolean mBroadcasterAudioEnabled = true;
    private String mActiveViewerStreamId = null;

    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        mRootView = (ConstraintLayout)inflater.inflate(R.layout.page_one_on_one_video, container, false);
        mUnbinder = ButterKnife.bind(this, mRootView);

        // Add the broadcaster video-view.
        mVideoViewBroadcaster = new PSPVideoView(getContext());
        mVideoViewBroadcaster.setBackgroundColor(Color.BLACK);
        mVideoViewBroadcaster.setVideoScaleBehavior(VideoScaleBehavior.FILL);
        mFrameBroadcasterVideo.addView(mVideoViewBroadcaster);
        mVideoViewBroadcaster.setOnClickListener((View v) -> {
            mVideoViewBroadcaster.toggleVideoScaleBehavior();
        });

        // Local broadcaster frames come in as an empty streamId, so set
        // that on our broadcaster videoView.
        mVideoViewBroadcaster.setStreamId("");

        // Add the friend video-view.
        mVideoViewFriend = new PSPVideoView(getContext());
        mVideoViewFriend.setBackgroundColor(Color.DKGRAY);
        mVideoViewFriend.setVideoScaleBehavior(VideoScaleBehavior.FILL);
        mFrameFriendVideo.addView(mVideoViewFriend);
        mVideoViewFriend.setOnClickListener((View v) -> {
            mVideoViewFriend.toggleVideoScaleBehavior();
        });

        return mRootView;
    }

    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        super.onServiceConnected(name, service);

        // Initialize UI to current state of the service.
        updateUIState();

        createVideoStreamer();
    }

    private void createVideoStreamer() {
        mBroadcasterVideoEnabled = true;
        mBroadcasterAudioEnabled = true;

        // Initialize the videoStreamer.
        mVideoStreamer = mClientAppService.getClientApp().getVideoStreamer();
        VideoStreamOptions options = new VideoStreamOptions(mBroadcasterAudioEnabled, 100, 100, mBroadcasterVideoEnabled, 640, 480, VideoFrameOrientation.ROTATE0);
        VideoStreamerObserver videoObserver = new VideoStreamerObserver() {
            @Override
            public void onVideoStreamDisplayFrameReceived(String streamId, byte[] buffer, int width, int height, VideoFrameOrientation orientation) {
                // Relay the frame for display in the appropriate videoView based on matching streamId.
                PSPVideoView.onVideoFrame(streamId, buffer, width, height);
            }

            @Override
            public void onVideoStreamDestroyed(String streamId) {
                statusLog("onVideoStreamDestroyed() " + streamId);

                // Clear the appropriate videoView based on matching streamId.
                PSPVideoView.clear(streamId);
            }
        };

        mVideoStreamer.enableVideoCapture(mBroadcasterVideoEnabled);
        mVideoStreamer.enableAudioCapture(mBroadcasterAudioEnabled);
        mVideoStreamer.initialize(options, videoObserver);
    }

    @OnClick(R.id.btn_one_on_one_broadcast)
    protected void startBroadcast() {
        statusLog("Starting broadcast stream");
        mVideoStreamer.startStreaming(new VideoStreamRequestHandler() {
            @Override
            public void onVideoStreamStarted(String streamId) {
                statusLog("Broadcaster: onVideoStreamStarted() " + streamId);

                AppUtils.copyToClipboard(getActivity(), "streamId", streamId);
                AppUtils.showToast(getActivity(), "Broadcaster streamId copied to clipboard");

                // TEMP: auto-populate the viewer textbox with this streamId
                mFriendStreamId.setText(streamId);

                mActiveBroadcast = true;
                updateUIState();
            }

            @Override
            public void onVideoStreamError(VideoStreamErrorId errorId) {
                statusLog("Broadcaster: onVideoStreamError() " + errorId);

                mActiveBroadcast = false;
                updateUIState();
            }
        });
    }

    @OnClick(R.id.btn_one_on_one_toggle_video)
    protected void toggleBroadcasterVideo() {
        mBroadcasterVideoEnabled = !mBroadcasterVideoEnabled;

        statusLog("Setting broadcaster video enabled: " + mBroadcasterVideoEnabled);
        mVideoStreamer.enableVideoCapture(mBroadcasterVideoEnabled);

        updateUIState();
    }

    @OnClick(R.id.btn_one_on_one_toggle_audio)
    protected void toggleBroadcasterAudio() {
        mBroadcasterAudioEnabled = !mBroadcasterAudioEnabled;

        statusLog("Setting broadcaster audio enabled: " + mBroadcasterAudioEnabled);
        mVideoStreamer.enableAudioCapture(mBroadcasterAudioEnabled);

        updateUIState();
    }

    @OnClick(R.id.btn_one_on_one_stop_broadcast)
    protected void stopBroadcast() {
        statusLog("Stopping broadcast");
        mVideoStreamer.stopStreaming();

        mActiveBroadcast = false;
        updateUIState();
    }

    @OnClick(R.id.btn_one_on_one_view)
    protected void startViewer() {
        String streamId = mFriendStreamId.getText().toString();
        if (streamId.isEmpty()) {
            AppUtils.showToast(getActivity(), "Must enter streamId to view");
            return;
        }

        statusLog("Starting viewer for stream: " + streamId);
        mVideoStreamer.startViewing(streamId, new VideoStreamRequestHandler() {
            @Override
            public void onVideoStreamStarted(String streamId) {
                statusLog("Viewer: onVideoStreamStarted() " + streamId);

                // Associate this streamId with our viewer videoView.
                mVideoViewFriend.setStreamId(streamId);

                mActiveViewerStreamId = streamId;
                updateUIState();
            }

            @Override
            public void onVideoStreamError(VideoStreamErrorId errorId) {
                statusLog("Viewer: onVideoStreamError() " + errorId);

                mActiveViewerStreamId = null;
                updateUIState();
            }
        });
    }

    @OnClick(R.id.btn_one_on_one_stop_viewer)
    protected void stopViewer() {
        statusLog("Stopping viewer: " + mActiveViewerStreamId);
        mVideoStreamer.stopViewing(mActiveViewerStreamId);

        mActiveViewerStreamId = null;
        updateUIState();
    }

    private void updateUIState() {
        getActivity().runOnUiThread(() -> {
            mStartBroadcasterButton.setEnabled(mClientAppService.isLoggedIn() && !mActiveBroadcast);
            mStopBroadcasterButton.setEnabled(mClientAppService.isLoggedIn() && mActiveBroadcast);
            mToggleBroadcasterVideoButton.setText(mBroadcasterVideoEnabled ? "Disable Video" : "Enable Video");
            mToggleBroadcasterAudioButton.setText(mBroadcasterAudioEnabled ? "Disable Audio" : "Enable Audio");

            boolean alreadyViewing = mActiveViewerStreamId != null;
            mStartViewerButton.setEnabled(mClientAppService.isLoggedIn() && !alreadyViewing);
            mStopViewerButton.setEnabled(mClientAppService.isLoggedIn() && alreadyViewing);
        });
    }

    private void statusLog(String msg) {
        AppUtils.statusLog(getContext(), TAG, msg);
    }
}
