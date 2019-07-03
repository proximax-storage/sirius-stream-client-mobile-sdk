package com.peerstream.psp.sdk;

import android.content.Context;

import com.peerstream.psp.sdk.util.LogUtil;

import java.lang.ref.WeakReference;

public class PSPContext {

    private static final String TAG = PSPContext.class.getSimpleName();

    private static PSPContext INSTANCE = null;

//    private boolean DID_REG_BROADCASTER = false;
//    private native void RegisterBroadcasterContext(Context context);
//
//    private boolean DID_REG_VIEWER = false;
//    private native void RegisterViewerContext(Context context);

    private boolean DID_REG_APP = false;
    private native void RegisterApplicationContext(Context context);

    private WeakReference<Context> mAppContext = null;
    private static final String ERROR_MSG_APP_CONTEXT_NOT_REGISTERED = "Application context not initialized";

    private PSPContext() {
    }

    public static PSPContext getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new PSPContext();
        }
        return INSTANCE;
    }

    public void initAppContext(Context context) {
        LogUtil.info(TAG, "Initializing app context");
        mAppContext = new WeakReference<>(context);

        LogUtil.info(TAG, "Initializing libraries");
        System.loadLibrary("jingle_peerconnection_so");
        System.loadLibrary("CoreSDK");
        System.loadLibrary("pspsdk");
    }

    public void ensureRegisterAppContext() {
        if (!DID_REG_APP) {

            // If the application context has not been initialized, abort.
            if (mAppContext == null) {
                throw new IllegalStateException(
                        ERROR_MSG_APP_CONTEXT_NOT_REGISTERED);
            }

//            LogUtil.info("Registering application context: " +
//                         mAppContext.get());
            LogUtil.info(TAG, "Registering app context");
            RegisterApplicationContext(mAppContext.get());
            DID_REG_APP = true;
        }
    }

//    public void ensureRegisterBroadcasterContext() {
//        if (!DID_REG_BROADCASTER) {
//
//            // If the application context has not been initialized, abort.
//            if (mAppContext == null) {
//                throw new IllegalStateException(ERROR_MSG_APP_CONTEXT_NOT_REGISTERED);
//            }
//
//            LogUtil.info("Registering broadcaster context: " + mAppContext.get());
//            RegisterBroadcasterContext(mAppContext.get());
//            DID_REG_BROADCASTER = true;
//        }
//    }
//
//    public void ensureRegisterViewerContext() {
//        if (!DID_REG_VIEWER) {
//
//            // If the application context has not been initialized, abort.
//            if (mAppContext == null) {
//                throw new IllegalStateException(ERROR_MSG_APP_CONTEXT_NOT_REGISTERED);
//            }
//
//            LogUtil.info("Registering viewer context");
//            RegisterViewerContext(mAppContext.get());
//            DID_REG_VIEWER = true;
//        }
//    }
}
