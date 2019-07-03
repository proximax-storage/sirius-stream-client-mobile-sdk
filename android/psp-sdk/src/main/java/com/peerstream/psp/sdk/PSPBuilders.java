package com.peerstream.psp.sdk;

import com.peerstream.psp.sdk.bridge.ClientApp;
import com.peerstream.psp.sdk.bridge.ClientAppConfig;
import com.peerstream.psp.sdk.bridge.ClientAppObserver;
import com.peerstream.psp.sdk.util.BridgeFactory;

public class PSPBuilders {

    public static class ClientAppBuilder {

        private ClientAppConfig mAppConfig = null;
        private ClientAppObserver mAppObserver = null;

        public ClientAppBuilder(ClientAppConfig appConfig, ClientAppObserver appObserver) {
            mAppConfig = appConfig;
            mAppObserver = appObserver;
        }

        public ClientApp build() {
            ClientApp clientApp = new BridgeFactory().createClientApp(mAppConfig, mAppObserver);
            return clientApp;
        }
    }
}
