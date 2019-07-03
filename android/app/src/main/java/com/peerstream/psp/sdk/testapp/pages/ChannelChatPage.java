package com.peerstream.psp.sdk.testapp.pages;

import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.ToggleButton;

import com.peerstream.psp.sdk.bridge.Channel;
import com.peerstream.psp.sdk.bridge.ChannelErrorId;
import com.peerstream.psp.sdk.bridge.ChannelObserver;
import com.peerstream.psp.sdk.bridge.ChannelRequestErrorId;
import com.peerstream.psp.sdk.bridge.ChannelStreamHandler;
import com.peerstream.psp.sdk.bridge.ClientChannelHandler;
import com.peerstream.psp.sdk.bridge.ClientChannelSecurity;
import com.peerstream.psp.sdk.bridge.VideoFrameOrientation;
import com.peerstream.psp.sdk.bridge.VideoStreamDevice;
import com.peerstream.psp.sdk.bridge.VideoStreamErrorId;
import com.peerstream.psp.sdk.bridge.VideoStreamOptions;
import com.peerstream.psp.sdk.bridge.VideoStreamRequestHandler;
import com.peerstream.psp.sdk.bridge.VideoStreamer;
import com.peerstream.psp.sdk.bridge.VideoStreamerObserver;
import com.peerstream.psp.sdk.testapp.R;
import com.peerstream.psp.sdk.testapp.services.ClientAppServiceImpl;
import com.peerstream.psp.sdk.testapp.utils.AppUtils;
import com.peerstream.psp.sdk.videoview.PSPVideoView;
import com.peerstream.psp.sdk.videoview.VideoScaleBehavior;

import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class ChannelChatPage extends BasePage {

    private static final String TAG = ChannelChatPage.class.getSimpleName();

    private static final String PREFS_CREATE_CHANNEL_USERID = "createChannelUserId";

    private ConstraintLayout mRootView = null;

    @BindView(R.id.edit_channel_chat_channel_userid) EditText mChannelUserId;
    @BindView(R.id.toggle_channel_chat_channel_security) ToggleButton mChannelSecureToggle;
    @BindView(R.id.btn_channel_chat_create_channel) Button mCreateChannel;
    @BindView(R.id.btn_channel_chat_user_lookup) Button mLookupPresenceButton;
    @BindView(R.id.btn_channel_chat_accept_channel) Button mAcceptChannel;
    @BindView(R.id.toggle_channel_chat_accept_channel_security) ToggleButton mAccepthannelSecureToggle;
    @BindView(R.id.btn_channel_chat_deny_channel) Button mDenyChannel;
    @BindView(R.id.edit_channel_chat_send_msg) EditText mSendMsgText;
    @BindView(R.id.btn_channel_chat_send_msg) Button mSendMsgButton;
    @BindView(R.id.btn_channel_chat_send_msg_raw) Button mSendMsgAsRawButton;
    @BindView(R.id.btn_channel_chat_channel_close) Button mCloseChannelButton;
    @BindView(R.id.toggle_channel_enable_cam) ToggleButton mEnableCamToggle;
    @BindView(R.id.toggle_channel_enable_mic) ToggleButton mEnableMicToggle;
    @BindView(R.id.btn_channel_chat_init_streamer) Button mInitStreamerButton;
    @BindView(R.id.btn_channel_cycle_cam) ImageButton mCycleCamButton;
    @BindView(R.id.btn_channel_chat_share_stream) Button mShareStreamButton;
    @BindView(R.id.btn_channel_chat_confirm_stream) Button mConfirmStreamButton;
    @BindView(R.id.btn_channel_chat_deny_stream) Button mDenyStreamButton;
    @BindView(R.id.frm_channel_chat_broadcaster) FrameLayout mFrameBroadcasterVideo;
    @BindView(R.id.frm_channel_chat_viewer) FrameLayout mFrameViewerVideo;
    @BindView(R.id.btn_channel_chat_stop_stream) Button mStopStreamButton;
    @BindView(R.id.btn_channel_chat_stop_viewer) Button mStopViewingButton;

    private String mChannelRequestedByUserId = null;
    private Channel mActiveChannel = null;
    private String mSharedStreamId = null;
    private String mBroadcastingStreamId = null;
    private String mViewingStreamId = null;

    PSPVideoView mVideoViewBroadcaster = null;
    PSPVideoView mVideoViewFriend = null;

    VideoStreamer mVideoStreamer = null;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        LocalBroadcastManager.getInstance(getContext())
                .registerReceiver(mClientAppObserverReceiver, new IntentFilter(ClientAppServiceImpl.EVENT_CLIENT_APP_OBSERVER));
    }

    private BroadcastReceiver mClientAppObserverReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            String eventName = intent.getStringExtra("event");

            switch (eventName) {
                case "onChannelRequested":
                    // We received a channel invite from this user.
                    mChannelRequestedByUserId = intent.getStringExtra("userId");
                    break;
            }

            updateUIState();
        }
    };

    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        mRootView = (ConstraintLayout)inflater.inflate(R.layout.page_channel_chat, container, false);
        mUnbinder = ButterKnife.bind(this, mRootView);

        mChannelUserId.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                updateUIState();
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

        // Populate stored userId if we have one.
        SharedPreferences sharedPref = getActivity().getPreferences(Context.MODE_PRIVATE);
        String sUserId = sharedPref.getString(PREFS_CREATE_CHANNEL_USERID, null);
        if (sUserId != null) {
            mChannelUserId.setText(sUserId);
        }

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
        mFrameViewerVideo.addView(mVideoViewFriend);
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
    }

    @Override
    public void onDestroy() {
        super.onDestroy();

        LocalBroadcastManager.getInstance(getContext()).unregisterReceiver(mClientAppObserverReceiver);
    }

    @OnClick(R.id.btn_channel_chat_create_channel)
    protected void createChannel() {
        String userId = mChannelUserId.getText().toString();
        ClientChannelSecurity security = mChannelSecureToggle.isChecked() ?
                ClientChannelSecurity.SECURE : ClientChannelSecurity.INSECURE;
        statusLog("Creating " + security + " channel with user: " + userId);

        // Store this userId to auto-repopulate on launch later.
        SharedPreferences sharedPref = getActivity().getPreferences(Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPref.edit();
        editor.putString(PREFS_CREATE_CHANNEL_USERID, userId);
        editor.commit();

        mClientAppService.getClientApp().createChannel(userId, security, new ClientChannelHandler() {
            @Override
            public void onChannelConfirmed(String clientId, Channel channel) {
                statusLog("CreateChannel: onChannelConfirmed: " + channel);

                setActiveChannel(channel);
            }

            @Override
            public void onChannelResponseError(String clientId, ChannelRequestErrorId errorId) {
                statusLog("CreateChannel: onChannelResponseError: " + errorId);
            }
        });
    }

    @OnClick(R.id.btn_channel_chat_accept_channel)
    protected void acceptChannel() {
        ClientChannelSecurity security = mAccepthannelSecureToggle.isChecked() ?
                ClientChannelSecurity.SECURE : ClientChannelSecurity.INSECURE;
        statusLog("Accepting " + security + " channel with user: " + mChannelRequestedByUserId);

        mClientAppService.getClientApp().confirmChannel(mChannelRequestedByUserId, security, new ClientChannelHandler() {
            @Override
            public void onChannelConfirmed(String clientId, Channel channel) {
                statusLog("ConfirmChannel: onChannelConfirmed: " + channel);

                setActiveChannel(channel);
            }

            @Override
            public void onChannelResponseError(String clientId, ChannelRequestErrorId errorId) {
                statusLog("ConfirmChannel: onChannelResponseError: " + errorId);
            }
        });

        mChannelRequestedByUserId = null;
        updateUIState();
    }

    @OnClick(R.id.btn_channel_chat_deny_channel)
    protected void denyChannel() {
        statusLog("Denying channel with user: " + mChannelRequestedByUserId);
        mClientAppService.getClientApp().denyChannel(mChannelRequestedByUserId);

        mChannelRequestedByUserId = null;
        updateUIState();
    }


    @OnClick(R.id.btn_channel_chat_send_msg)
    protected void sendMsg() {
        String msg = mSendMsgText.getText().toString();
        statusLog("SendMsg: " + msg);

        mActiveChannel.sendMessage(msg);
        mSendMsgText.setText("");
    }

    @OnClick(R.id.btn_channel_chat_send_msg_raw)
    protected void sendMsgAsRaw() {
        String msg = mSendMsgText.getText().toString();
        statusLog("SendMsgRaw: " + msg);

        mActiveChannel.sendRawData(msg.getBytes());
        mSendMsgText.setText("");
    }

    private void setActiveChannel(Channel channel) {
        mActiveChannel = channel;

        mActiveChannel.setObserver(new ChannelObserver() {
            @Override
            public void onStreamShared(String channelId, String streamId) {
                statusLog("ChannelEvent: onStreamShared: " + channelId + " : " + streamId);

                mSharedStreamId = streamId;
                updateUIState();
            }

            @Override
            public void onRawReceived(String channelId, byte[] data) {
                String payload = new String(data);
                statusLog("ChannelEvent: onRawReceived: " + payload);
            }

            @Override
            public void onStreamRequested(String channelId) {
                statusLog("ChannelEvent: onStreamRequested: " + channelId);
            }

            @Override
            public void onMessageReceived(String channelId, String msg) {
                statusLog("ChannelEvent: onMessageReceived: " + msg);
            }

            @Override
            public void onChannelError(String channelId, ChannelErrorId errorId) {
                statusLog("ChannelEvent: onChannelError: " + errorId);

                closeChannel();
            }
        });

        updateUIState();
    }

    @OnClick(R.id.toggle_channel_enable_cam)
    protected void toggleCam() {
        if (mVideoStreamer == null) {
            return;
        }

        mVideoStreamer.enableVideoCapture(mEnableCamToggle.isChecked());
    }

    @OnClick(R.id.toggle_channel_enable_mic)
    protected void toggleMic() {
        if (mVideoStreamer == null) {
            return;
        }

        mVideoStreamer.enableAudioCapture(mEnableMicToggle.isChecked());
    }

    @OnClick(R.id.btn_channel_chat_init_streamer)
    protected void initVideoStreamer() {
        if (mVideoStreamer != null) {
            return;
        }

        boolean enableVideo = mEnableCamToggle.isChecked();
        boolean enableAudio = mEnableMicToggle.isChecked();

        // Initialize the videoStreamer.
        mVideoStreamer = mClientAppService.getClientApp().getVideoStreamer();
        VideoStreamOptions options = new VideoStreamOptions(enableAudio, 100, 100, enableVideo, 640, 480, VideoFrameOrientation.ROTATE0);
        VideoStreamerObserver videoObserver = new VideoStreamerObserver() {
            @Override
            public void onVideoStreamDisplayFrameReceived(String streamId, byte[] buffer, int width, int height, VideoFrameOrientation orientation) {
                //LogUtil.info(TAG, "!!!! FRAME " + streamId);
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
        mVideoStreamer.enableVideoCapture(enableVideo);
        mVideoStreamer.enableAudioCapture(enableAudio);
        mVideoStreamer.initialize(options, videoObserver);

        updateUIState();
    }

    @OnClick(R.id.btn_channel_cycle_cam)
    protected void cycleCamera() {
        if (mVideoStreamer == null) {
            return;
        }

        List<VideoStreamDevice> devices = mVideoStreamer.getVideoDevices();
        if (devices.size() == 0) {
            statusLog("No devices found");
            return;
        }


        int currentDevice = mVideoStreamer.selectedVideoDevice();
        statusLog("Current device: " + currentDevice + " of " + devices.size());

        // Cycle to next device index.
        currentDevice++;
        if (currentDevice >= devices.size()) {
            currentDevice = 0;
        }
        statusLog("Setting device index: " + currentDevice);
        mVideoStreamer.setVideoDevice(currentDevice);
    }

    @OnClick(R.id.btn_channel_chat_share_stream)
    protected void shareStream() {
        if (mVideoStreamer == null) {
            return;
        }

        statusLog("Starting local stream");
        mVideoStreamer.startStreaming(new VideoStreamRequestHandler() {
            @Override
            public void onVideoStreamStarted(String streamId) {
                statusLog("ShareStream: onVideoStreamStarted: " + streamId);

                mBroadcastingStreamId = streamId;
                updateUIState();

                shareStreamOverChannel();
            }

            @Override
            public void onVideoStreamError(VideoStreamErrorId errorId) {
                statusLog("ShareStream: onVideoStreamError: " + errorId);

                mBroadcastingStreamId = null;
                updateUIState();
            }
        });
    }

    private void shareStreamOverChannel() {
        statusLog("Sharing stream");
        mActiveChannel.shareStream(new ChannelStreamHandler() {
            @Override
            public void onStreamCreated(String channelId, String streamId) {
                statusLog("ShareStream: onStreamCreated: " + streamId);
            }

            @Override
            public void onStreamError(String channelId, VideoStreamErrorId errorId) {
                statusLog("ShareStream: onStreamError: " + errorId);
            }
        });

        updateUIState();
    }

    @OnClick(R.id.btn_channel_chat_confirm_stream)
    protected void confirmStream() {
        statusLog("Confirming stream");
        mActiveChannel.confirmVideoStreamShare(new ChannelStreamHandler() {
            @Override
            public void onStreamCreated(String channelId, String streamId) {
                statusLog("ConfirmStream: onStreamCreated: " + streamId);

                // Associate this streamId with our viewer videoView.
                mVideoViewFriend.setStreamId(streamId);


                new Handler(Looper.getMainLooper()).postDelayed(() -> {
                    handleStartViewingSharedStream(streamId);
                }, 1000);

                // handleStartViewingSharedStream(streamId);
            }

            @Override
            public void onStreamError(String channelId, VideoStreamErrorId errorId) {
                statusLog("ConfirmStream: onStreamError: " + errorId);
            }
        });

        mSharedStreamId = null;
        updateUIState();
    }

    private void handleStartViewingSharedStream(String streamId) {
        statusLog("Viewing confirmed stream");
        mVideoStreamer.startViewing(streamId, new VideoStreamRequestHandler() {
            @Override
            public void onVideoStreamStarted(String streamId) {
                statusLog("ConfirmStream: onVideoStreamStarted: " + streamId);
                mViewingStreamId = streamId;
                updateUIState();
            }

            @Override
            public void onVideoStreamError(VideoStreamErrorId errorId) {
                statusLog("ConfirmStream: onVideoStreamError: " + errorId);
                mViewingStreamId = null;
                updateUIState();
            }
        });
    }

    @OnClick(R.id.btn_channel_chat_deny_stream)
    protected void denyStream() {
        statusLog("Denying stream");
        mActiveChannel.denyVideoStreamShare();

        mSharedStreamId = null;
        updateUIState();
    }

    @OnClick(R.id.btn_channel_chat_stop_stream)
    protected void stopStream() {
        if (mVideoStreamer == null) {
            return;
        }

        statusLog("Stopping broadcast stream");
        mVideoStreamer.stopStreaming();

        mBroadcastingStreamId = null;
        updateUIState();
    }

    @OnClick(R.id.btn_channel_chat_stop_viewer)
    protected void stopViewing() {
        if (mVideoStreamer == null) {
            return;
        }

        if (mViewingStreamId != null) {
            statusLog("Stopping viewer stream: " + mViewingStreamId);
            mVideoStreamer.stopViewing(mViewingStreamId);
            mViewingStreamId = null;
            updateUIState();
        }
    }

    @OnClick(R.id.btn_channel_chat_channel_close)
    protected void closeChannel() {
        if (mActiveChannel != null) {
            statusLog("Closing active channel");
            mActiveChannel.close();
        }

        mActiveChannel = null;
        updateUIState();
    }

    private void updateUIState() {
        if (mClientAppService == null) {
            return;
        }

        getActivity().runOnUiThread(() -> {
            boolean hasPopulatedUserId = !mChannelUserId.getText().toString().isEmpty();
            mCreateChannel.setEnabled(hasPopulatedUserId && mClientAppService.isLoggedIn());
            mChannelSecureToggle.setEnabled(hasPopulatedUserId && mClientAppService.isLoggedIn());

            boolean hasActiveChannel = mActiveChannel != null;
            mLookupPresenceButton.setEnabled(hasActiveChannel);
            mSendMsgText.setEnabled(hasActiveChannel);
            mSendMsgButton.setEnabled(hasActiveChannel);
            mSendMsgAsRawButton.setEnabled(hasActiveChannel);
            mCloseChannelButton.setEnabled(hasActiveChannel);

            boolean isAcceptDenyEnabled = mChannelRequestedByUserId != null;
            mAcceptChannel.setEnabled(isAcceptDenyEnabled);
            mAccepthannelSecureToggle.setEnabled(isAcceptDenyEnabled);
            mDenyChannel.setEnabled(isAcceptDenyEnabled);

            boolean hasVideoStreamer = mVideoStreamer != null;
            mInitStreamerButton.setEnabled(!hasVideoStreamer);
            mCycleCamButton.setEnabled(hasVideoStreamer);

            mShareStreamButton.setEnabled(hasActiveChannel && hasVideoStreamer);
            boolean hasSharedStream = mSharedStreamId != null;
            mConfirmStreamButton.setEnabled(hasSharedStream);
            mDenyStreamButton.setEnabled(hasSharedStream);

            mStopStreamButton.setEnabled(mBroadcastingStreamId != null);
            mStopViewingButton.setEnabled(mViewingStreamId != null);
        });
    }

    private void statusLog(String msg) {
        AppUtils.statusLog(getContext(), TAG, msg);
    }
}
