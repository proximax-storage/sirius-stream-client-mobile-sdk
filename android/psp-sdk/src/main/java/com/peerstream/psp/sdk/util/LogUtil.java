package com.peerstream.psp.sdk.util;

import android.util.Log;

public class LogUtil {

    public static final String LOG_TAG = "PSP-SDK";

    public static void info(String msg) {
        info(LOG_TAG, msg);
    }

    public static void info(String tag, String msg) {
        Log.i(tag, msg);
    }

    public static void error(String msg, Throwable err) {
        error(LOG_TAG, msg, err);
    }

    public static void error(String tag, String msg, Throwable err) {
        Log.e(tag, msg, err);
    }
}

