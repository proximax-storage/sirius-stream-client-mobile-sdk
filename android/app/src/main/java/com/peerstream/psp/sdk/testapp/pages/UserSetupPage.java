package com.peerstream.psp.sdk.testapp.pages;


import android.Manifest;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.IBinder;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import com.google.gson.Gson;
import com.peerstream.psp.sdk.bridge.ClientLoginFailureCode;
import com.peerstream.psp.sdk.bridge.ClientLoginHandler;
import com.peerstream.psp.sdk.bridge.ClientRegisterFailureCode;
import com.peerstream.psp.sdk.bridge.ClientRegisterHandler;
import com.peerstream.psp.sdk.bridge.ClientRegistrationData;
import com.peerstream.psp.sdk.testapp.R;
import com.peerstream.psp.sdk.testapp.services.ClientAppServiceImpl;
import com.peerstream.psp.sdk.testapp.utils.AppUtils;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;
import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import permissions.dispatcher.NeedsPermission;
import permissions.dispatcher.OnNeverAskAgain;
import permissions.dispatcher.OnPermissionDenied;
import permissions.dispatcher.RuntimePermissions;

@RuntimePermissions
public class UserSetupPage extends BasePage {

    private static final String TAG = UserSetupPage.class.getSimpleName();

    private static final String PREFS_REG_DATA = "regData";
    private static final String PREFS_REG_DATA_EXPIRED = "regDataExpired";

    private ConstraintLayout mRootView = null;

    @BindView(R.id.btn_setup_start) Button mStartButton;
    @BindView(R.id.btn_setup_stop) Button mStopButton;
    @BindView(R.id.txt_setup_started_state) TextView mStartedStateText;
    @BindView(R.id.btn_setup_register) Button mRegisterButton;
    @BindView(R.id.txt_setup_register_state) TextView mRegisterStateText;
    @BindView(R.id.btn_setup_login) Button mLoginButton;
    @BindView(R.id.btn_setup_login_expired_user) Button mLoginExpiredUserButton;
    @BindView(R.id.btn_setup_copy_identity) Button mCopyIdentity;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        LocalBroadcastManager.getInstance(getContext())
                .registerReceiver(mClientAppObserverReceiver, new IntentFilter(ClientAppServiceImpl.EVENT_CLIENT_APP_OBSERVER));
    }

    private BroadcastReceiver mClientAppObserverReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            String eventName = intent.getStringExtra("event");

            updateUIState();
        }
    };

    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        mRootView = (ConstraintLayout)inflater.inflate(R.layout.page_user_setup, container, false);
        mUnbinder = ButterKnife.bind(this, mRootView);

        return mRootView;
    }

    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        super.onServiceConnected(name, service);

        // Initialize UI to current state of the service.
        updateUIState();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();

        LocalBroadcastManager.getInstance(getContext()).unregisterReceiver(mClientAppObserverReceiver);
    }

    @OnClick(R.id.btn_setup_start)
    protected void clickedStart() {
        UserSetupPagePermissionsDispatcher.startClientAppWithPermissionCheck(UserSetupPage.this);
    }

    @OnClick(R.id.btn_setup_stop)
    protected void clickedStop() {
        mClientAppService.stopClientApp();

        updateUIState();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        // NOTE: delegate the permission handling to generated method
        UserSetupPagePermissionsDispatcher.onRequestPermissionsResult(this, requestCode, grantResults);
    }

    @NeedsPermission({Manifest.permission.RECORD_AUDIO, Manifest.permission.CAMERA})
    void startClientApp() {
        mClientAppService.startClientApp();
    }

    @OnPermissionDenied({Manifest.permission.RECORD_AUDIO, Manifest.permission.CAMERA})
    void onCameraDenied() {
        AppUtils.showToast(getActivity(), "Requires cam and mic permissions to start");
    }

    @OnNeverAskAgain({Manifest.permission.RECORD_AUDIO, Manifest.permission.CAMERA})
    void onCameraNeverAskAgain() {
        AppUtils.showToast(getActivity(), "Camera or mic has been denied - cannot continue");
    }

    @OnClick(R.id.btn_setup_register)
    protected void registerNewUser() {
        mClientAppService.registerUser(new ClientRegisterHandler() {
            @Override
            public void onRegisterSuccess(String clientId, ClientRegistrationData userData) {
                // Persist registration data
                storeLogin(userData);

                updateUIState();
            }

            @Override
            public void onRegisterFailure(String clientId, ClientRegisterFailureCode code) {
                updateUIState();
            }
        });
    }

    @OnClick(R.id.btn_setup_login)
    protected void login() {
        ClientRegistrationData userData = readStoredLogin();

        mClientAppService.login(userData, new ClientLoginHandler() {
            @Override
            public void onLoginSuccess(String clientId, String response, ClientRegistrationData data) {
                // If data is returned, then we have a refreshed cert, so we
                // need to store it.
                if (data != null) {
                    storeLogin(data);
                }

                updateUIState();
            }

            @Override
            public void onLoginFailure(String clientId, ClientLoginFailureCode code) {
                updateUIState();
            }
        });
    }

    @OnClick(R.id.btn_setup_login_expired_user)
    protected void loginExpiredUser() {
        ClientRegistrationData userData = readStoredLogin(PREFS_REG_DATA_EXPIRED);

        mClientAppService.login(userData, new ClientLoginHandler() {
            @Override
            public void onLoginSuccess(String clientId, String response, ClientRegistrationData data) {
                if (data != null) {
                    storeLogin(data);
                }

                updateUIState();
            }

            @Override
            public void onLoginFailure(String clientId, ClientLoginFailureCode code) {
                updateUIState();
            }
        });
    }

    @OnClick(R.id.btn_setup_copy_identity)
    protected void copyIdentityToClipboard() {
        AppUtils.copyToClipboard(getActivity(), "identity", mClientAppService.getCurrentUserIdentity());
        AppUtils.showToast(getActivity(), "Identity copied to clipboard");
    }

    private void updateUIState() {
        getActivity().runOnUiThread(() -> {
            String startedState = mClientAppService.isStarted() ? "Started" : "Not Started";
            mStartedStateText.setText(startedState);
            String registerState = mClientAppService.isRegistered() ? "Registered" : "Not Registered";
            mRegisterStateText.setText(registerState);

            mStartButton.setEnabled(!mClientAppService.isStarted());
            mStopButton.setEnabled(mClientAppService.isStarted());
            mRegisterButton.setEnabled(mClientAppService.isStarted());
            mLoginButton.setEnabled(mClientAppService.isStarted() && readStoredLogin() != null);
            mLoginExpiredUserButton.setEnabled(mClientAppService.isStarted() && readStoredLogin(PREFS_REG_DATA_EXPIRED) != null);
            mCopyIdentity.setEnabled(mClientAppService.isLoggedIn());
        });
    }

    private void storeLogin(ClientRegistrationData userData) {
        storeLogin(userData, PREFS_REG_DATA);
    }

    private void storeLogin(ClientRegistrationData userData, String fieldKey) {
        Gson gson = new Gson();
        String sRegData = gson.toJson(userData);
        SharedPreferences sharedPref = getActivity().getPreferences(Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPref.edit();
        editor.putString(fieldKey, sRegData);
        editor.commit();
    }

    private ClientRegistrationData readStoredLogin() {
        return readStoredLogin(PREFS_REG_DATA);
    }

    private ClientRegistrationData readStoredLogin(String fieldKey) {
        ClientRegistrationData result = null;
        SharedPreferences sharedPref = getActivity().getPreferences(Context.MODE_PRIVATE);
        String sRegData = sharedPref.getString(fieldKey, null);
        if (sRegData != null) {
            Gson gson = new Gson();
            result = gson.fromJson(sRegData, ClientRegistrationData.class);
        }
        return result;
    }

    private void statusLog(String msg) {
        AppUtils.statusLog(getContext(), TAG, msg);
    }
}
