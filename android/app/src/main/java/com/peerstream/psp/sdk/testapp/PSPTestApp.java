package com.peerstream.psp.sdk.testapp;

import android.app.Application;
import android.util.Log;

import com.peerstream.psp.sdk.PSPContext;
import com.peerstream.psp.sdk.bridge.ClientApp;

public class PSPTestApp extends Application {

    private static final String TAG = PSPTestApp.class.getSimpleName();

    private ClientApp mClientApp = null;

    public void onCreate() {
        super.onCreate();

        // Give the Live-SDK our application context.
        Log.i(TAG, "Sending app context: " + getApplicationContext());
        PSPContext.getInstance().initAppContext(getApplicationContext());
    }
}
