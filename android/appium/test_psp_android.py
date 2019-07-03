"""

Prerequisites:
sudo easy_install pip
pip install Appium-Python-Client
sudo easy_install nose

Run this test by executing this command line:

python test_psp_android.py
 or
nosetests test_psp_android.py

If script wants to send_keys (https://github.com/appium/python-client/issues/162):
pip uninstall selenium
pip install selenium==3.3.1

"""

 
import os
import unittest
import time
from time import sleep
 
from appium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
#from selenium.webdriver.support import expected_conditions as EC
#from selenium.webdriver.common.by import By

class AndroidTests(unittest.TestCase):
    "Class to run tests against the app"

    def setUp(self):
        "Setup for the test"

        '''
        From https://github.com/appium/appium/blob/master/docs/en/writing-running-appium/caps.md
        |Capability|Description|Values|
        |----|-----------|-------|
        |`automationName`|Which automation engine to use|`Appium` (default) or `Selendroid`|
        |`platformName`|Which mobile OS platform to use|`iOS`, `Android`, or `FirefoxOS`|
        |`platformVersion`|Mobile OS version|e.g., `7.1`, `4.4`|
        |`deviceName`|The kind of mobile device or emulator to use|`iPhone Simulator`, `iPad Simulator`, `iPhone Retina 4-inch`, `Android Emulator`, `Galaxy S4`, etc.... On iOS, this should be one of the valid devices returned by instruments with `instruments -s devices`. On Android this capability is currently ignored.|
        |`app`|The absolute local path _or_ remote http URL to an `.ipa` or `.apk` file, or a `.zip` containing one of these. Appium will attempt to install this app binary on the appropriate device first. Note that this capability is not required for Android if you specify `appPackage` and `appActivity` capabilities (see below). Incompatible with `browserName`.|`/abs/path/to/my.apk` or `http://myapp.com/app.ipa`|
        |`browserName`|Name of mobile web browser to automate. Should be an empty string if automating an app instead.|'Safari' for iOS and 'Chrome', 'Chromium', or 'Browser' for Android|
        |`newCommandTimeout`|How long (in seconds) Appium will wait for a new command from the client before assuming the client quit and ending the session|e.g. `60`|
        |`language`| (Sim/Emu-only) Language to set for the simulator / emulator |e.g. `fr`|
        |`locale`| (Sim/Emu-only) Locale to set for the simulator / emulator |e.g. `fr_CA`|
        |`udid`| Unique device identifier of the connected physical device|e.g. `1ae203187fc012g`|
        |`orientation`| (Sim/Emu-only) start in a certain orientation|`LANDSCAPE` or `PORTRAIT`|
        |`autoWebview`| Move directly into Webview context. Default `false`|`true`, `false`|
        |`noReset`|Don't reset app state before this session. Default `false`|`true`, `false`|
        |`fullReset`|(iOS) Delete the entire simulator folder. (Android) Reset app state by uninstalling app instead of clearing app data. On Android, this will also remove the app after the session is complete. Default `false`|`true`, `false`|
       
        ANDROID-ONLY
        Capability              Description Values
        appActivity             Activity name for the Android activity you want to launch from your package. This often needs to be preceded by a . (e.g., .MainActivity instead of MainActivity)   MainActivity, .Settings
        appPackage              Java package of the Android app you want to run com.example.android.myApp, com.android.settings
        appWaitActivity         Activity name/names, comma separated, for the Android activity you want to wait for SplashActivity, SplashActivity,OtherActivity, *, *.SplashActivity
        appWaitPackage          Java package of the Android app you want to wait for    com.example.android.myApp, com.android.settings
        appWaitDuration         Timeout in milliseconds used to wait for the appWaitActivity to launch (default 20000)  30000
        deviceReadyTimeout      Timeout in seconds while waiting for device to become ready 5
        androidCoverage         Flagsully qualified instrumentation class. Passed to -w in adb shell am instrument -e coverage true -w  com.my.Pkg/com.my.Pkg.instrumentation.MyInstrumentation
        androidDeviceReadyTimeout   Timeout in seconds used to wait for a device to become ready after booting  e.g., 30
        androidInstallTimeout   Timeout in milliseconds used to wait for an apk to install to the device. Defaults to 90000 e.g., 90000
        androidInstallPath      The name of the directory on the device in which the apk will be push before install. Defaults to /data/local/tmp   e.g. /sdcard/Downloads/
        adbPort                 Port used to connect to the ADB server (default 5037)   5037
        remoteAdbHost           Optional remote ADB server host e.g.: 192.168.0.101
        androidDeviceSocket     Devtools socket name. Needed only when tested app is a Chromium embedding browser. The socket is open by the browser and Chromedriver connects to it as a devtools client.  e.g., chrome_devtools_remote
        avd                     Name of avd to launch   e.g., api19
        avdLaunchTimeout        How long to wait in milliseconds for an avd to launch and connect to ADB (default 120000)   300000
        avdReadyTimeout         How long to wait in milliseconds for an avd to finish its boot animations (default 120000)  300000
        avdArgs                 Additional emulator arguments used when launching an avd    e.g., -netfast
        useKeystore             Use a custom keystore to sign apks, default false   true or false
        keystorePath            Path to custom keystore, default ~/.android/debug.keystore  e.g., /path/to.keystore
        keystorePassword        Password for custom keystore    e.g., foo
        keyAlias                Alias for key   e.g., androiddebugkey
        keyPassword             Password for key    e.g., foo
        chromedriverExecutable  The absolute local path to webdriver executable (if Chromium embedder provides its own webdriver, it should be used instead of original chromedriver bundled with Appium)   /abs/path/to/webdriver
        autoWebviewTimeout      Amount of time to wait for Webview context to become active, in ms. Defaults to 2000    e.g. 4
        intentAction            Intent action which will be used to start activity (default android.intent.action.MAIN) e.g.android.intent.action.MAIN, android.intent.action.VIEW
        intentCategory          Intent category which will be used to start activity (default android.intent.category.LAUNCHER) e.g. android.intent.category.LAUNCHER, android.intent.category.APP_CONTACTS
        intentFlags             Flags that will be used to start activity (default 0x10200000)  e.g. 0x10200000
        optionalIntentArguments Additional intent arguments that will be used to start activity. See Intent arguments   e.g. --esn <EXTRA_KEY>, --ez <EXTRA_KEY> <EXTRA_BOOLEAN_VALUE>, etc.
        dontStopAppOnReset      Doesn't stop the process of the app under test, before starting the app using adb. If the app under test is created by another anchor app, setting this false, allows the process of the anchor app to be still alive, during the start of the test app using adb. In other words, with dontStopAppOnReset set to true, we will not include the -S flag in the adb shell am start call. With this capability omitted or set to false, we include the -S flag. Default false true or false
        unicodeKeyboard         Enable Unicode input, default false true or false
        resetKeyboard           Reset keyboard to its original state, after running Unicode tests with unicodeKeyboard capability. Ignored if used alone. Default false true or false
        noSign                  Skip checking and signing of app with debug keys, will work only with UiAutomator and not with selendroid, default false    true or false
        ignoreUnimportantViews  Calls the setCompressedLayoutHierarchy() uiautomator function. This capability can speed up test execution, since Accessibility commands will run faster ignoring some elements. The ignored elements will not be findable, which is why this capability has also been implemented as a toggle-able setting as well as a capability. Defaults to false  true or false
        disableAndroidWatchers  Disables android watchers that watch for application not responding and application crash, this will reduce cpu usage on android device/emulator. This capability will work only with UiAutomator and not with selendroid, default false    true or false
        chromeOptions           Allows passing chromeOptions capability for ChromeDriver. For more information see chromeOptions    chromeOptions: {args: ['--disable-popup-blocking']}
        recreateChromeDriverSessions    Kill ChromeDriver session when moving to a non-ChromeDriver webview. Defaults to false  true or false
        nativeWebScreenshot     In a web context, use native (adb) method for taking a screenshot, rather than proxying to ChromeDriver. Defaults to false  true or false
        androidScreenshotPath   The name of the directory on the device in which the screenshot will be put. Defaults to /data/local/tmp    e.g. /sdcard/screenshots/
        autoGrantPermissions    Have Appium automatically determine which permissions your app requires and grant them to the app on install. Defaults to false true or false
        '''

        timestamp = str(time.time())
        timestamp = timestamp.replace('.', '')

        desired_caps = {}
        desired_caps['platformName']            = 'Android'
        desired_caps['deviceName']              = 'whatever'
        desired_caps['appPackage']              = 'com.peerstream.psp.sdk.testapp'
        desired_caps['appActivity']             = '.DrawerBaseActivity'
        desired_caps['autoGrantPermissions']    = True

        '''
        #desired_caps['autoDismissAlerts']       = True;
        #desired_caps['newCommandTimeout']       = '180'

        #no need to specify "app" if "appPackage" and "appActivity" are specified (we specify "app" here for local tests, AWS will use "appPackage" and "appActivity")
        desired_caps['app']              = os.path.abspath(os.path.join(os.path.dirname(__file__),'../test-app/build/outputs/apk/debug/test-app-debug.apk'))
        '''
        self.driver = webdriver.Remote('http://localhost:4723/wd/hub', desired_caps)
        


    def tearDown(self):
        "Tear down the test"
        self.driver.quit()
 

    t0 = 0
    def log(self, st):
        timestamp = '{:f}'.format(time.time() - self.t0) 
        logLine = timestamp + ": " + " " + st
        print logLine

    # ---------------------------------
    # ----------- Utilities -----------
    # ---------------------------------

    def util_click_button_by_id(self, button_id):
        wd = self.driver
        self.log ("... clicking button [" + button_id + "]")
        wd.find_element_by_id("com.peerstream.psp.sdk.testapp:id/" + button_id).click()

    def util_get_field_text_value(self, field_id):
        wd = self.driver
        self.log ("... getting field value for [" + field_id + "]")
        retVal = wd.find_element_by_id("com.peerstream.psp.sdk.testapp:id/" + field_id).text
        return retVal

    def util_set_field_text_value(self, field_id, input_text):
        wd = self.driver
        self.log ("... setting field [" + field_id + "] value to [" + input_text + "]")
        wd.find_element_by_id("com.peerstream.psp.sdk.testapp:id/" + field_id).set_value(input_text)

    def util_wait(self, numSeconds):
        self.log ("... waiting [" + str(numSeconds) + "] second(s)")
        sleep(numSeconds)

    # ---------------------------------
    # -------- User Setup Page --------
    # ---------------------------------

    def routine_nav_to_user_setup_page(self):
        wd = self.driver
        self.log ("Routine: nav to user setup page")
        wd.find_element_by_accessibility_id('Open navigation drawer').click()
        wd.find_element_by_accessibility_id('Menu User Setup').click()

    def routine_setup_start_clientapp(self):
        self.log ("Routine: starting clientApp")
        self.util_click_button_by_id("btn_setup_start")
        self.util_wait(2)

    def routine_setup_stop_clientapp(self):
        self.log ("Routine: stopping clientApp")
        self.util_click_button_by_id("btn_setup_stop")
        self.util_wait(2)

    def verify_setup_clientapp_started_state(self, expectedState):
        actualState = self.util_get_field_text_value("txt_setup_started_state")
        self.log("... clientApp started has state [" + actualState + "]; expected [" + expectedState + "]")
        self.assertEqual(expectedState, actualState)

    def routine_setup_start_register(self):
        self.log ("Routine: registering")
        self.util_click_button_by_id("btn_setup_register")
        self.util_wait(4)

    def verify_setup_register_state(self, expectedState):
        actualState = self.util_get_field_text_value("txt_setup_register_state")
        self.log("... register state [" + actualState + "]; expected [" + expectedState + "]")
        self.assertEqual(expectedState, actualState)

    # ---------------------------------
    # ------- Channel Chat Page -------
    # ---------------------------------

    def routine_nav_to_channel_chat_page(self):
        wd = self.driver
        self.log ("Routine: nav to channel chat page")
        wd.find_element_by_accessibility_id('Open navigation drawer').click()
        self.util_wait(1)
        wd.find_element_by_accessibility_id('Menu Channel Chat').click()

    # ---------------------------------
    # ------------- Tests -------------
    # ---------------------------------

    def test_clientapp_start_and_stop(self):
        self.log ("START: test_clientapp_start_and_stop")
        self.routine_nav_to_user_setup_page()
        # Verify in not-started state
        self.verify_setup_clientapp_started_state("Not Started")
        # Start clientApp
        self.routine_setup_start_clientapp()
        # Verify now in started state
        self.verify_setup_clientapp_started_state("Started")
        # Cleanup: Stop clientApp
        self.routine_setup_stop_clientapp()
        self.log ("END: test_clientapp_start_and_stop")

    def test_register_user(self):
        self.log ("START: test_register_user")
        self.routine_nav_to_user_setup_page()
        # Start clientApp
        self.routine_setup_start_clientapp()
        # Verify in started state
        self.verify_setup_clientapp_started_state("Started")
        # Verify not yet registered
        self.verify_setup_register_state("Not Registered")
        # Register a new user
        self.routine_setup_start_register()
        # Verify now registered
        self.verify_setup_register_state("Registered")
        # Cleanup: Stop clientApp
        self.routine_setup_stop_clientapp()
        self.log ("END: test_register_user")

if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(AndroidTests)
    unittest.TextTestRunner(verbosity=2).run(suite)





