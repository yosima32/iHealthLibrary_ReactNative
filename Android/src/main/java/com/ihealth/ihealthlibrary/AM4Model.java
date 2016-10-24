package com.ihealth.ihealthlibrary;

import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import com.ihealth.communication.manager.*;
import com.ihealth.communication.control.*;

/**
 * Created by jing on 16/10/20.
 */

public class AM4Model extends ReactContextBaseJavaModule {
    private static final String modelName = "AM4Model";
    private static final String TAG = "AM4Model";

    public AM4Model(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return modelName;
    }

    @ReactMethod
    public void getBattery(String mac) {
        Am4Control am4Control = iHealthDevicesManager.getInstance().getAm4Control(mac);
        if (am4Control != null) {
            am4Control.getUserId();
        } else {
            Log.e(TAG,"mac:" + mac);
        }
    }

}
