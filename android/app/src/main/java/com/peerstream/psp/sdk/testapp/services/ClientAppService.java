package com.peerstream.psp.sdk.testapp.services;

import com.peerstream.psp.sdk.bridge.ClientApp;
import com.peerstream.psp.sdk.bridge.ClientAppObserver;
import com.peerstream.psp.sdk.bridge.ClientLoginHandler;
import com.peerstream.psp.sdk.bridge.ClientRegisterHandler;
import com.peerstream.psp.sdk.bridge.ClientRegistrationData;

public interface ClientAppService {

    void startClientApp();
    void stopClientApp();

    void registerUser(ClientRegisterHandler externalRegisterHandler);

    void login(ClientLoginHandler externalLoginHandler);
    void login(ClientRegistrationData clientRegistrationData, ClientLoginHandler externalLoginHandler);

    ClientApp getClientApp();

    boolean isStarted();

    boolean isRegistered();

    boolean isLoggedIn();

    String getCurrentUserIdentity();
}
