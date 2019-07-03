package com.peerstream.psp.sdk.util;

import com.peerstream.psp.sdk.bridge.ClientApp;
import com.peerstream.psp.sdk.bridge.ClientAppConfig;
import com.peerstream.psp.sdk.bridge.ClientAppObserver;

public class BridgeFactory {

    private static final String TAG = BridgeFactory.class.getSimpleName();

    public BridgeFactory() {

    }

    public ClientApp createClientApp(ClientAppConfig clientAppConfig, ClientAppObserver clientAppObserver) {
        return ClientApp.create(clientAppConfig, clientAppObserver);
    }
}
