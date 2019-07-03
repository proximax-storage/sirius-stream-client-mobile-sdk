package com.peerstream.psp.sdk.testapp.pages;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;

import com.peerstream.psp.sdk.testapp.BaseFragment;
import com.peerstream.psp.sdk.testapp.services.ClientAppService;
import com.peerstream.psp.sdk.testapp.services.ClientAppServiceImpl;

public abstract class BasePage extends BaseFragment implements ServiceConnection {

    private static final String TAG = BasePage.class.getSimpleName();

    protected ClientAppService mClientAppService = null;

    @Override
    public void onStart() {
        super.onStart();

        Intent intent= new Intent(getActivity(), ClientAppServiceImpl.class);
        getActivity().bindService(intent, this, Context.BIND_AUTO_CREATE);
    }

    @Override
    public void onResume() {
        super.onResume();
    }

    @Override
    public void onPause() {
        super.onPause();
    }

    @Override
    public void onStop() {
        super.onStop();

        getActivity().unbindService(this);
    }

    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        ClientAppServiceImpl.MyBinder binder = (ClientAppServiceImpl.MyBinder)service;
        mClientAppService = binder.getService();
    }

    @Override
    public void onServiceDisconnected(ComponentName name) {
        mClientAppService = null;
    }
}
