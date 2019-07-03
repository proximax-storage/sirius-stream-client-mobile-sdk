// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

package com.peerstream.psp.sdk.bridge;

import java.util.concurrent.atomic.AtomicBoolean;

public abstract class ClientApp {
    public abstract void start();

    public abstract void stop();

    public abstract void setMinLogLevel(ClientLogLevel level);

    public abstract void registerUser(ClientRegisterHandler handler);

    public abstract void login(ClientRegistrationData userData, ClientLoginHandler handler);

    public abstract String getIdentity();

    public abstract VideoStreamer getVideoStreamer();

    public abstract void createChannel(String userId, ClientChannelSecurity security, ClientChannelHandler handler);

    public abstract void confirmChannel(String userId, ClientChannelSecurity security, ClientChannelHandler handler);

    public abstract void denyChannel(String userId);

    public abstract void registerUserPresenceChange(String userId);

    public abstract void unregisterUserPresenceChange(String userId);

    public static ClientApp create(ClientAppConfig config, ClientAppObserver observer)
    {
        return CppProxy.create(config,
                               observer);
    }

    private static final class CppProxy extends ClientApp
    {
        private final long nativeRef;
        private final AtomicBoolean destroyed = new AtomicBoolean(false);

        private CppProxy(long nativeRef)
        {
            if (nativeRef == 0) throw new RuntimeException("nativeRef is zero");
            this.nativeRef = nativeRef;
        }

        private native void nativeDestroy(long nativeRef);
        public void _djinni_private_destroy()
        {
            boolean destroyed = this.destroyed.getAndSet(true);
            if (!destroyed) nativeDestroy(this.nativeRef);
        }
        protected void finalize() throws java.lang.Throwable
        {
            _djinni_private_destroy();
            super.finalize();
        }

        @Override
        public void start()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_start(this.nativeRef);
        }
        private native void native_start(long _nativeRef);

        @Override
        public void stop()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_stop(this.nativeRef);
        }
        private native void native_stop(long _nativeRef);

        @Override
        public void setMinLogLevel(ClientLogLevel level)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_setMinLogLevel(this.nativeRef, level);
        }
        private native void native_setMinLogLevel(long _nativeRef, ClientLogLevel level);

        @Override
        public void registerUser(ClientRegisterHandler handler)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_registerUser(this.nativeRef, handler);
        }
        private native void native_registerUser(long _nativeRef, ClientRegisterHandler handler);

        @Override
        public void login(ClientRegistrationData userData, ClientLoginHandler handler)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_login(this.nativeRef, userData, handler);
        }
        private native void native_login(long _nativeRef, ClientRegistrationData userData, ClientLoginHandler handler);

        @Override
        public String getIdentity()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getIdentity(this.nativeRef);
        }
        private native String native_getIdentity(long _nativeRef);

        @Override
        public VideoStreamer getVideoStreamer()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getVideoStreamer(this.nativeRef);
        }
        private native VideoStreamer native_getVideoStreamer(long _nativeRef);

        @Override
        public void createChannel(String userId, ClientChannelSecurity security, ClientChannelHandler handler)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_createChannel(this.nativeRef, userId, security, handler);
        }
        private native void native_createChannel(long _nativeRef, String userId, ClientChannelSecurity security, ClientChannelHandler handler);

        @Override
        public void confirmChannel(String userId, ClientChannelSecurity security, ClientChannelHandler handler)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_confirmChannel(this.nativeRef, userId, security, handler);
        }
        private native void native_confirmChannel(long _nativeRef, String userId, ClientChannelSecurity security, ClientChannelHandler handler);

        @Override
        public void denyChannel(String userId)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_denyChannel(this.nativeRef, userId);
        }
        private native void native_denyChannel(long _nativeRef, String userId);

        @Override
        public void registerUserPresenceChange(String userId)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_registerUserPresenceChange(this.nativeRef, userId);
        }
        private native void native_registerUserPresenceChange(long _nativeRef, String userId);

        @Override
        public void unregisterUserPresenceChange(String userId)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            native_unregisterUserPresenceChange(this.nativeRef, userId);
        }
        private native void native_unregisterUserPresenceChange(long _nativeRef, String userId);

        public static native ClientApp create(ClientAppConfig config, ClientAppObserver observer);
    }
}
