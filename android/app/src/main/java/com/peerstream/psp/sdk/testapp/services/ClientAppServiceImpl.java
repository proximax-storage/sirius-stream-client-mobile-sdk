package com.peerstream.psp.sdk.testapp.services;

import android.app.Service;
import android.content.Intent;
import android.os.Binder;
import android.os.IBinder;
import android.util.Log;

import com.peerstream.psp.sdk.PSPBuilders;
import com.peerstream.psp.sdk.PSPContext;
import com.peerstream.psp.sdk.bridge.ClientApp;
import com.peerstream.psp.sdk.bridge.ClientAppConfig;
import com.peerstream.psp.sdk.bridge.ClientAppExitCode;
import com.peerstream.psp.sdk.bridge.ClientAppObserver;
import com.peerstream.psp.sdk.bridge.ClientBootstrapNode;
import com.peerstream.psp.sdk.bridge.ClientLoginFailureCode;
import com.peerstream.psp.sdk.bridge.ClientLoginHandler;
import com.peerstream.psp.sdk.bridge.ClientNetworkStatus;
import com.peerstream.psp.sdk.bridge.ClientRegisterFailureCode;
import com.peerstream.psp.sdk.bridge.ClientRegisterHandler;
import com.peerstream.psp.sdk.bridge.ClientRegistrationData;
import com.peerstream.psp.sdk.testapp.utils.AppUtils;

import androidx.annotation.Nullable;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

public class ClientAppServiceImpl extends Service implements ClientAppService {

    private static final String TAG = ClientAppService.class.getSimpleName();

    public static final String EVENT_CLIENT_APP_OBSERVER = "client-app-observer-event";

    private ClientApp mClientApp = null;
    private boolean mIsStarted = false;
    private ClientRegistrationData mCurrentRegisteredUser = null;
    private boolean mIsLoggedIn = false;



    @Override
    public void startClientApp() {
        if (mClientApp != null) {
            Log.w(TAG, "Already started");
            return;
        }

        ClientBootstrapNode clientBootstreamNode = new ClientBootstrapNode("discovery", "", "15BD35F29D087DC1E33F5E4B2A0C7551C8212A506CBB1E946D299F7CFE892578", "psp.discovery.node.2h2CF1JrVkbYFn2ynq5atK4FV6kRLepHEZFMLmAxRAjQzm9AJX", "dev.peerstreamprotocol.com:6001");

        ClientAppConfig clientAppConfig = new ClientAppConfig("peerstream", "client", clientBootstreamNode);

        ClientAppObserver clientAppObserver = new ClientAppObserver() {
            @Override
            public void onApplicationReady(String clientId) {
                statusLog("onApplicationReady()");
                mIsStarted = true;

                sendClientAppObserverEvent("onApplicationReady");
            }

            @Override
            public void onApplicationExit(ClientAppExitCode code) {
                statusLog("onApplicationFailed() " + code);

                reset();

                sendClientAppObserverErrorEvent("onApplicationFailed", code.toString());
            }

            @Override
            public void onChannelRequested(String clientId, final String userId) {
                statusLog("onChannelRequested() " + userId);

                sendClientAppObserverEvent("onChannelRequested", userId);
            }

            @Override
            public void onNetworkStatus(String clientId, ClientNetworkStatus status) {
                // not relaying at this point
            }

            @Override
            public void onUserPresenceChange(String clientId, String userId, boolean isActive) {
                statusLog("onUserPresenceChange() " + userId + ", active? " + isActive);

                // not relaying at this point
            }
        };

        mClientApp = new PSPBuilders.ClientAppBuilder(
                clientAppConfig,
                clientAppObserver).build();

        // FIXME: Shouldn't have to do this yet.
        statusLog("Ensuring application context");
        PSPContext.getInstance().ensureRegisterAppContext();

        statusLog("Starting clientApp");
        mClientApp.start();
    }

    private void reset() {
        // Clear our references.
        mClientApp = null;
        mIsStarted = false;
        mIsLoggedIn = false;
    }

    @Override
    public void stopClientApp() {
        if (!isStarted()) {
            Log.w(TAG, "Not started");
            return;
        }

        statusLog("Stopping clientApp...");
        mClientApp.stop();

        reset();
    }

    private void sendClientAppObserverEvent(String event) {
        Intent intent = new Intent(EVENT_CLIENT_APP_OBSERVER);
        intent.putExtra("event", event);
        LocalBroadcastManager.getInstance(this).sendBroadcast(intent);
    }

    private void sendClientAppObserverEvent(String event, String userId) {
        Intent intent = new Intent(EVENT_CLIENT_APP_OBSERVER);
        intent.putExtra("event", event);
        intent.putExtra("userId", userId);
        LocalBroadcastManager.getInstance(this).sendBroadcast(intent);
    }

    private void sendClientAppObserverErrorEvent(String event, String error) {
        Intent intent = new Intent(EVENT_CLIENT_APP_OBSERVER);
        intent.putExtra("event", event);
        intent.putExtra("error", error);
        LocalBroadcastManager.getInstance(this).sendBroadcast(intent);
    }

    @Override
    public void registerUser(ClientRegisterHandler externalRegisterHandler) {
        if (!isStarted()) {
            Log.w(TAG, "Not started");
            return;
        }

        statusLog("Registering new user...");
        mClientApp.registerUser(new ClientRegisterHandler() {
            @Override
            public void onRegisterSuccess(String clientId, ClientRegistrationData userData) {
                statusLog("onRegisterSuccess() " + userData.getIdentity());
                mCurrentRegisteredUser = userData;
                mIsLoggedIn = false;

                externalRegisterHandler.onRegisterSuccess(clientId, userData);
            }

            @Override
            public void onRegisterFailure(String clientId, ClientRegisterFailureCode code) {
                statusLog("onRegisterFailure() " + code);
                mCurrentRegisteredUser = null;
                mIsLoggedIn = false;

                externalRegisterHandler.onRegisterFailure(clientId, code);
            }
        });
    }

    @Override
    public void login(ClientLoginHandler externalLoginHandler) {
        if (!isRegistered()) {
            Log.w(TAG, "Not registered");
            return;
        }

        login(mCurrentRegisteredUser, externalLoginHandler);
    }

    @Override
    public void login(ClientRegistrationData clientRegistrationData, ClientLoginHandler externalLoginHandler) {
        mCurrentRegisteredUser = clientRegistrationData;

        mClientApp.login(clientRegistrationData, new ClientLoginHandler() {
            @Override
            public void onLoginSuccess(String clientId, String response, ClientRegistrationData data) {
                statusLog("onLoginSuccess() " + response);
                mIsLoggedIn = true;

                externalLoginHandler.onLoginSuccess(clientId, response, data);
            }

            @Override
            public void onLoginFailure(String clientId, ClientLoginFailureCode code) {
                statusLog("onLoginFailure() " + code);
                mIsLoggedIn = false;

                externalLoginHandler.onLoginFailure(clientId, code);
            }
        });
    }

    @Override
    public ClientApp getClientApp() {
        return mClientApp;
    }

    @Override
    public boolean isStarted() {
        return mIsStarted;
    }

    @Override
    public boolean isRegistered() {
        return isStarted() && mCurrentRegisteredUser != null;
    }

    @Override
    public boolean isLoggedIn() {
        return isRegistered() && mIsLoggedIn;
    }

    @Override
    public String getCurrentUserIdentity() {
        return isRegistered() ? mCurrentRegisteredUser.getIdentity() : null;
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return myBinder;
    }

    private MyBinder myBinder = new MyBinder();

    public class MyBinder extends Binder {
        public ClientAppServiceImpl getService() {
            return ClientAppServiceImpl.this;
        }
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        return Service.START_NOT_STICKY;
    }

    private void statusLog(String msg) {
        AppUtils.statusLog(this, TAG, msg);
    }
}
