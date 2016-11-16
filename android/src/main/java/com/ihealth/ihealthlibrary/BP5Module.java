package com.ihealth.ihealthlibrary;

import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.ihealth.communication.control.Bp5Control;

import com.ihealth.communication.control.BpProfile;
import com.ihealth.communication.manager.*;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

/**
 * Created by jing on 16/10/24.
 */

public class BP5Module extends ReactContextBaseJavaModule {

    private static final String modelName = "BP5Module";
    private static final String TAG = "BP5Module";

    private static final String Action_Battery = "Action_Battery";
    private static final String Action_Zeroing = "Action_Zeroing";
    private static final String Action_ZeroOver = "Action_ZeroOver";
    private static final String Action_Pressure = "Action_Pressure";
    private static final String Action_PulseWave = "Action_PulseWave";
    private static final String Action_Result = "Action_Result";



    public BP5Module(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> constants = new HashMap<>();
        constants.put(Action_Battery,BpProfile.ACTION_BATTERY_BP);
        constants.put(Action_Zeroing, BpProfile.ACTION_ZOREING_BP);
        constants.put(Action_ZeroOver, BpProfile.ACTION_ZOREOVER_BP);
        constants.put(Action_Pressure, BpProfile.ACTION_ONLINE_PRESSURE_BP);
        constants.put(Action_PulseWave,BpProfile.ACTION_ONLINE_PULSEWAVE_BP);
        constants.put(Action_Result, BpProfile.ACTION_ONLINE_RESULT_BP);


        return constants;
    }

    @Override
    public String getName() {
        return modelName;
    }

    @ReactMethod
    public void startMeasure(String mac) {
        Bp5Control bp5Control = iHealthDevicesManager.getInstance().getBp5Control(mac);
        if (bp5Control != null) {
            bp5Control.startMeasure();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            iHealthDeviceManagerModule.sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void stopMeasure(String mac) {
        Bp5Control bp5Control = iHealthDevicesManager.getInstance().getBp5Control(mac);
        if (bp5Control != null) {
            bp5Control.interruptMeasure();
        } else {
            WritableMap params = Arguments.createMap();
            params.putInt("errorid",400);
            iHealthDeviceManagerModule.sendEvent("Error", params);
        }
    }

    @ReactMethod
    public void Logger(String tag, String msg) {
        Log.e(TAG, msg);
    }


    public static WritableMap handleNotify(String mac, String deviceType, String action, String message) {
        switch (action) {
            case BpProfile.ACTION_BATTERY_BP:

                break;
            case BpProfile.ACTION_ZOREING_BP:

                break;
            case BpProfile.ACTION_ZOREOVER_BP:

                break;
            case BpProfile.ACTION_ONLINE_PRESSURE_BP:

                break;
            case BpProfile.ACTION_ONLINE_PULSEWAVE_BP:

                break;
            case BpProfile.ACTION_ONLINE_RESULT_BP:

                break;
            default:
                break;
        }
        WritableMap params = Arguments.createMap();
        params.putString("mac", mac);
        params.putString("type", deviceType);
        Utils.jsonToMap(message, params);

        return params;
    }
}