package com.peerstream.psp.sdk.util;

import android.content.Context;
import android.graphics.Bitmap;
import android.renderscript.Allocation;
import android.renderscript.Element;
import android.renderscript.RenderScript;
import android.renderscript.ScriptIntrinsicYuvToRGB;
import android.renderscript.Type;

public class YUVtoRBG {

    private RenderScript mRs = null;
    private ScriptIntrinsicYuvToRGB mScript = null;

    public YUVtoRBG(Context context) {
        mRs = RenderScript.create(context);
        mScript = ScriptIntrinsicYuvToRGB.create(mRs, Element.U8_4(mRs));
    }

    public void fillBitmap(byte[] yuvFrame, int width, int height, Bitmap bitmap) {
        Type.Builder yuvType = new Type.Builder(mRs, Element.U8(mRs))
                .setX(width)
                .setY(height)
                .setYuvFormat(android.graphics.ImageFormat.YV12);
        Allocation in = Allocation.createTyped(mRs, yuvType.create(), Allocation.USAGE_SCRIPT);

        Type.Builder rgbaType = new Type.Builder(mRs, Element.RGBA_8888(mRs))
                .setX(width)
                .setY(height);
        Allocation out = Allocation.createTyped(mRs, rgbaType.create(), Allocation.USAGE_SCRIPT);

        in.copyFrom(yuvFrame);

        mScript.setInput(in);
        mScript.forEach(out);
        out.copyTo(bitmap);
    }
}
