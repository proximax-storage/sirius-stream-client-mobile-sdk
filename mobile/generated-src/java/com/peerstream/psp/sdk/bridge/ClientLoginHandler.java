// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

package com.peerstream.psp.sdk.bridge;

public abstract class ClientLoginHandler {
    public abstract void onLoginSuccess(String clientId, String response, ClientRegistrationData data);

    public abstract void onLoginFailure(String clientId, ClientLoginFailureCode code);
}
