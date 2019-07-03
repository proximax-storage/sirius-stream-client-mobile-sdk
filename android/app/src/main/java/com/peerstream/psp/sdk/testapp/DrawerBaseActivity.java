package com.peerstream.psp.sdk.testapp;

import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.os.Bundle;

import com.crashlytics.android.Crashlytics;
import com.google.android.material.bottomsheet.BottomSheetBehavior;
import com.google.android.material.navigation.NavigationView;
import com.peerstream.psp.sdk.testapp.pages.BasePage;
import com.peerstream.psp.sdk.testapp.pages.ChannelChatPage;
import com.peerstream.psp.sdk.testapp.pages.OneOnOneVideoPage;
import com.peerstream.psp.sdk.testapp.pages.UserSetupPage;
import com.peerstream.psp.sdk.testapp.services.ClientAppService;
import com.peerstream.psp.sdk.testapp.services.ClientAppServiceImpl;
import com.peerstream.psp.sdk.testapp.utils.AppUtils;

import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.fragment.app.Fragment;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;
import io.fabric.sdk.android.Fabric;

import android.os.IBinder;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;

public class DrawerBaseActivity extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener, ServiceConnection {

    private static final String TAG = DrawerBaseActivity.class.getSimpleName();

    private ClientAppService mClientAppService = null;
    private boolean isClientAppServiceBound = false;

    private Fragment mCurrentPage = null;

    private BottomSheetBehavior mBottomSheetBehavior = null;
    private TextView mStatusLog = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_drawer_base);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.addDrawerListener(toggle);
        toggle.syncState();

        NavigationView navigationView = (NavigationView) findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);

        View bottomSheet = findViewById(R.id.content_bottom_sheet);
        mBottomSheetBehavior = BottomSheetBehavior.from(bottomSheet);

        mStatusLog = findViewById(R.id.content_log_text);

        LocalBroadcastManager.getInstance(this)
                .registerReceiver(mStatusReceiver, new IntentFilter(AppUtils.STATUS_EVENT));

        Fabric.with(this, new Crashlytics());

        AppUtils.statusLog(this, TAG, "Swipe up here to see more status messages");

        // Start on the user setup page.
        navigationView.getMenu().getItem(0).setChecked(true);
        showPage(R.id.nav_user_setup);
    }

    private BroadcastReceiver mStatusReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            String statusMsg = intent.getStringExtra("status");

            runOnUiThread(() -> {
                String text = mStatusLog.getText().toString();
                String newText = "* " + statusMsg + "\n" + text;
                mStatusLog.setText(newText);
            });
        }
    };

    @Override
    protected void onStart() {
        super.onStart();

        if (!isClientAppServiceBound) {
            Intent intent = new Intent(this, ClientAppServiceImpl.class);
            bindService(intent, this, Context.BIND_AUTO_CREATE);
            isClientAppServiceBound = true;
        }
    }

    @Override
    protected void onResume() {
        super.onResume();

        mBottomSheetBehavior.setPeekHeight(150);
        mBottomSheetBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);
    }

    @Override
    protected void onPause() {
        super.onPause();
    }

    @Override
    protected void onStop() {
        super.onStop();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        if (isClientAppServiceBound) {
            unbindService(this);
            mClientAppService = null;
            isClientAppServiceBound = false;
        }

        LocalBroadcastManager.getInstance(this).unregisterReceiver(mStatusReceiver);
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

    @Override
    public void onBackPressed() {
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.drawer_base, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement

        return super.onOptionsItemSelected(item);
    }

    @SuppressWarnings("StatementWithEmptyBody")
    @Override
    public boolean onNavigationItemSelected(MenuItem item) {
        // Handle navigation view item clicks here.
        int id = item.getItemId();

        showPage(id);

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;
    }

    private void removeCurrentPage() {
        try {
            // Remove current page
            if (mCurrentPage != null) {
                getSupportFragmentManager()
                        .beginTransaction()
                        .remove(mCurrentPage)
                        .commit();
                mCurrentPage = null;
            }
        } catch (Exception ex) {
            Log.e("TestApp", "Error removing page", ex);
        }
    }

    private void showPage(int id) {
        removeCurrentPage();

        BasePage fragment = null;
        switch (id) {
            case R.id.nav_user_setup:
                fragment = new UserSetupPage();
                break;
            case R.id.nav_channel_chat:
                fragment = new ChannelChatPage();
                break;
            case R.id.nav_one_on_one_video:
                fragment = new OneOnOneVideoPage();
                break;
        }

        // Add new page
        if (fragment != null) {
            mCurrentPage = fragment;
            getSupportFragmentManager()
                    .beginTransaction()
                    .replace(R.id.content_container, fragment)
                    .commit();
        }
    }
}
