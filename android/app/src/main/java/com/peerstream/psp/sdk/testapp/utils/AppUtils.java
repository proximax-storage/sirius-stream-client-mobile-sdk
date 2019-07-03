package com.peerstream.psp.sdk.testapp.utils;

import android.app.Activity;
import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.widget.Toast;

import androidx.localbroadcastmanager.content.LocalBroadcastManager;

public class AppUtils {

    public static final String STATUS_EVENT = "status-event";

    public static void copyToClipboard(Activity activity, String label, String text) {
        activity.runOnUiThread(() -> {
            ClipboardManager clipboardManager = (ClipboardManager)activity.getSystemService(Context.CLIPBOARD_SERVICE);
            ClipData clip = ClipData.newPlainText(label, text);
            clipboardManager.setPrimaryClip(clip);
        });
    }

    public static void showToast(Activity activity, String msg) {
        activity.runOnUiThread(() -> {
            Toast.makeText(activity, msg, Toast.LENGTH_SHORT).show();
        });
    }

    public static void statusLog(Context context, String tag, String msg) {
        Log.i(tag, msg);

        Intent intent = new Intent(STATUS_EVENT);
        intent.putExtra("status", msg);
        LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
    }
}
