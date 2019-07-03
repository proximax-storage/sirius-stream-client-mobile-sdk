package com.peerstream.psp.sdk.videoview.util;

import android.os.Handler;
import android.os.Looper;

import com.peerstream.psp.sdk.util.LogUtil;

import java.util.concurrent.Executor;

public class UIThreadExecutor implements Executor {

    private Handler mHandler;

    public UIThreadExecutor() {
        mHandler = new Handler(Looper.getMainLooper());
    }

    @Override
    public void execute(Runnable command) {
        try {
            mHandler.post(command);
        } catch (Exception ex) {
            LogUtil.error("UIThreadExecutor execute()", ex);
        }
    }
}

