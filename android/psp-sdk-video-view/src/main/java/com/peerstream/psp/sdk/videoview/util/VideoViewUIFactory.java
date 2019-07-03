package com.peerstream.psp.sdk.videoview.util;

import android.content.Context;
import android.graphics.Bitmap;


import androidx.appcompat.widget.AppCompatImageView;

public class VideoViewUIFactory {

    public VideoViewUIFactory() {
    }

    public static AppCompatImageView createImageView(Context context) {
        return new AppCompatImageView(context);
    }

    public static Bitmap createBitmap(int width, int height) {
        return Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
    }
}
