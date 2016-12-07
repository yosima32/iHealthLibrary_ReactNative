/**
 * Created by Jeepend on 15/11/2016.
 */
'use strict';


var {NativeModules} = require('react-native');

var RCTModule = NativeModules.AMProfileModule

/**
 * @module AMProfileModule
 */
module.exports = {
    // Actions
    /**
     * The action value of event indicating the error of AM device.<br/>
     * The key and value will be as below:
     * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>Value</td></tr>
     * <tr><td>action</td><td>AMProfileModule.ACTION_ERROR_AM</td></tr>
     * <tr><td>AMProfileModule.ERROR_NUM_AM</td><td>AMProfileModule.ERROR_ID_ILLEGAL_ARGUMENT(400) indicates parameter error.<br/>AMProfileModule.ERROR_ID_VERSION_NOT_SUPPORT(402) indicates version not support error.</td></tr>
     * <tr><td>AMProfileModule.ERROR_DESCRIPTION_AM</td><td>Detailed description of the error</td></tr>
     * </tbody>
     * </table>
     * <b>Example:</b><br/>
     * {<br/>
     * &nbsp; &nbsp; "action": "error_am",<br/>
     * &nbsp; &nbsp; "error": 400,<br/>
     * &nbsp; &nbsp; "description": "setAlarmClock() parameter min should be in the range [0, 59]."<br/>
     * }<br/>
     */
    ACTION_ERROR_AM: RCTModule.ACTION_ERROR_AM,
    /**
     * The action value of event indicating reset AM device finish.<br/>
     * The key and value will be as below:
     * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>Value</td></tr>
     * <tr><td>action</td><td>AMProfileModule.ACTION_RESET_AM</td></tr>
     * <tr><td>AMProfileModule.RESET_AM</td><td>0 indicates reset failed.<br/>1 indicates reset successfully.</td></tr>
     * </tbody>
     * </table>
     * <b>Example:</b><br/>
     * {<br/>
     * &nbsp; &nbsp; "action": "reset_am",<br/>
     * &nbsp; &nbsp; "reset": 1<br/>
     * }<br/>
     */
    ACTION_RESET_AM: RCTModule.ACTION_RESET_AM,
    /**
     * The action value of event indicating get user's ID successfully.<br/>
     * The key and value will be as below:
     * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>Value</td></tr>
     * <tr><td>action</td><td>AMProfileModule.ACTION_USERID_AM</td></tr>
     * <tr><td>AMProfileModule.USERID_AM</td><td>User's ID</td></tr>
     * </tbody>
     * </table>
     * <b>Example:</b><br/>
     * {<br/>
     * &nbsp; &nbsp; "action": "userid_am",<br/>
     * &nbsp; &nbsp; "userid": 123456<br/>
     * }<br/>
     */
    ACTION_USERID_AM: RCTModule.ACTION_USERID_AM,
    /**
     * The action value of event indicating set user's ID successfully.<br/>
     * The key and value will be as below:
     * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>Value</td></tr>
     * <tr><td>action</td><td>AMProfileModule.ACTION_SET_USERID_SUCCESS_AM</td></tr>
     * </tbody>
     * </table>
     * <b>Example:</b><br/>
     * {<br/>
     * &nbsp; &nbsp; "action": "set_userid_success_am",<br/>
     * }<br/>
     */
    ACTION_SET_USERID_SUCCESS_AM: RCTModule.ACTION_SET_USERID_SUCCESS_AM,
    ACTION_SYNC_TIME_SUCCESS_AM: RCTModule.ACTION_SYNC_TIME_SUCCESS_AM,
    /**
     * The action value of event indicating set user's information successfully.<br/>
     * The key and value will be as below:
     * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>Value</td></tr>
     * <tr><td>action</td><td>AMProfileModule.ACTION_SET_USERINFO_SUCCESS_AM</td></tr>
     * </tbody>
     * </table>
     * <b>Example:</b><br/>
     * {<br/>
     * &nbsp; &nbsp; "action": "set_userinfo_success_am",<br/>
     * }<br/>
     */
    ACTION_SET_USERINFO_SUCCESS_AM: RCTModule.ACTION_SET_USERINFO_SUCCESS_AM,
    ACTION_GET_USERINFO_AM: RCTModule.ACTION_GET_USERINFO_AM,
    ACTION_GET_ALARMNUM_AM: RCTModule.ACTION_GET_ALARMNUM_AM,
    ACTION_GET_ALARMINFO_AM: RCTModule.ACTION_GET_ALARMINFO_AM,
    /**
     * The action value of event indicating set/unset alarm successfully.<br/>
     * The key and value will be as below:
     * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>Value</td></tr>
     * <tr><td>action</td><td>AMProfileModule.ACTION_SET_ALARMINFO_SUCCESS_AM</td></tr>
     * </tbody>
     * </table>
     * <b>Example:</b><br/>
     * {<br/>
     * &nbsp; &nbsp; "action": "set_alarminfo_success_am",<br/>
     * }<br/>
     */
    ACTION_SET_ALARMINFO_SUCCESS_AM: RCTModule.ACTION_SET_ALARMINFO_SUCCESS_AM,
    ACTION_DELETE_ALARM_SUCCESS_AM: RCTModule.ACTION_DELETE_ALARM_SUCCESS_AM,
    ACTION_GET_ACTIVITY_REMIND_AM: RCTModule.ACTION_GET_ACTIVITY_REMIND_AM,
    /**
     * The action value of event indicating set/unset activity remind successfully.<br/>
     * The key and value will be as below:
     * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>Value</td></tr>
     * <tr><td>action</td><td>AMProfileModule.ACTION_SET_ACTIVITYREMIND_SUCCESS_AM</td></tr>
     * </tbody>
     * </table>
     * <b>Example:</b><br/>
     * {<br/>
     * &nbsp; &nbsp; "action": "set_activityremind_success_am",<br/>
     * }<br/>
     */
    ACTION_SET_ACTIVITYREMIND_SUCCESS_AM: RCTModule.ACTION_SET_ACTIVITYREMIND_SUCCESS_AM,
    ACTION_SYNC_ACTIVITY_DATA_AM: RCTModule.ACTION_SYNC_ACTIVITY_DATA_AM,
    ACTION_SYNC_SLEEP_DATA_AM: RCTModule.ACTION_SYNC_SLEEP_DATA_AM,
    ACTION_SYNC_STAGE_DATA_AM: RCTModule.ACTION_SYNC_STAGE_DATA_AM,
    ACTION_QUERY_STATE_AM: RCTModule.ACTION_QUERY_STATE_AM,
    ACTION_SYNC_REAL_DATA_AM: RCTModule.ACTION_SYNC_REAL_DATA_AM,
    /**
     * The action value of event indicating set user's basal metabolic rate successfully.<br/>
     * The key and value will be as below:
     * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>Value</td></tr>
     * <tr><td>action</td><td>AMProfileModule.ACTION_SET_BMR_SUCCESS_AM</td></tr>
     * </tbody>
     * </table>
     * <b>Example:</b><br/>
     * {<br/>
     * &nbsp; &nbsp; "action": "set_bmr_success_am",<br/>
     * }<br/>
     */
    ACTION_SET_BMR_SUCCESS_AM: RCTModule.ACTION_SET_BMR_SUCCESS_AM,
    ACTION_GET_SWIMINFO_AM: RCTModule.ACTION_GET_SWIMINFO_AM,
    /**
     * The action value of event indicating set swim information successfully.<br/>
     * The key and value will be as below:
     * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>Value</td></tr>
     * <tr><td>action</td><td>AMProfileModule.ACTION_SET_SWIMINFO_AM</td></tr>
     * </tbody>
     * </table>
     * <b>Example:</b><br/>
     * {<br/>
     * &nbsp; &nbsp; "action": "set_swiminfo_am",<br/>
     * }<br/>
     */
    ACTION_SET_SWIMINFO_AM: RCTModule.ACTION_SET_SWIMINFO_AM,
    ACTION_GET_RANDOM_AM: RCTModule.ACTION_GET_RANDOM_AM,
    /**
     * The action value of event indicating set swim information successfully.<br/>
     * The key and value will be as below:
     * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>Value</td></tr>
     * <tr><td>action</td><td>AMProfileModule.ACTION_SET_HOUR_MODE_SUCCESS_AM</td></tr>
     * </tbody>
     * </table>
     * <b>Example:</b><br/>
     * {<br/>
     * &nbsp; &nbsp; "action": "set_hour_mode_success_am",<br/>
     * }<br/>
     */
    ACTION_SET_HOUR_MODE_SUCCESS_AM: RCTModule.ACTION_SET_HOUR_MODE_SUCCESS_AM,
    ACTION_GET_HOUR_MODE_AM: RCTModule.ACTION_GET_HOUR_MODE_AM,
    /**
     * The action value of event indicating set swim information successfully.<br/>
     * The key and value will be as below:
     * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>Value</td></tr>
     * <tr><td>action</td><td>AMProfileModule.ACTION_SET_DEVICE_MODE_AM</td></tr>
     * </tbody>
     * </table>
     * <b>Example:</b><br/>
     * {<br/>
     * &nbsp; &nbsp; "action": "set_device_mode_am",<br/>
     * }<br/>
     */
    ACTION_SET_DEVICE_MODE_AM: RCTModule.ACTION_SET_DEVICE_MODE_AM,
    ACTION_CLOUD_BINDING_AM_SUCCESS: RCTModule.ACTION_CLOUD_BINDING_AM_SUCCESS,
    ACTION_CLOUD_BINDING_AM_FAIL: RCTModule.ACTION_CLOUD_BINDING_AM_FAIL,
    ACTION_CLOUD_UNBINDING_AM_SUCCESS: RCTModule.ACTION_CLOUD_UNBINDING_AM_SUCCESS,
    ACTION_CLOUD_UNBINDING_AM_FAIL: RCTModule.ACTION_CLOUD_UNBINDING_AM_FAIL,
    ACTION_CLOUD_SEARCH_AM: RCTModule.ACTION_CLOUD_SEARCH_AM,
    ACTION_CLOUD_SEARCH_FAIL_AM: RCTModule.ACTION_CLOUD_SEARCH_FAIL_AM,
    /**
     * The action value of event indicating set swim information successfully.<br/>
     * The key and value will be as below:
     * <table style="width:100px;" cellpadding="2" cellspacing="0" border="1" bordercolor="#000000">
     * <tbody>
     * <tr><td>Key</td><td>Value</td></tr>
     * <tr><td>action</td><td>AMProfileModule.ACTION_SET_PICTURE_SUCCESS_AM</td></tr>
     * </tbody>
     * </table>
     * <b>Example:</b><br/>
     * {<br/>
     * &nbsp; &nbsp; "action": "set_picture_success_am",<br/>
     * }<br/>
     */
    ACTION_SET_PICTURE_SUCCESS_AM: RCTModule.ACTION_SET_PICTURE_SUCCESS_AM,
    ACTION_GET_PICTURE_AM: RCTModule.ACTION_GET_PICTURE_AM,

    // Keys:
    /**
     * The key of error ID number of AM device.<br/>
     * <b>Value:</b>
     * <ul>
     * <li>{@link module:AMProfileModule.ERROR_ID_ILLEGAL_ARGUMENT AMProfileModule.ERROR_ID_ILLEGAL_ARGUMENT(400)} indicates parameter error.</li>
     * <li>{@link module:AMProfileModule.ERROR_ID_VERSION_NOT_SUPPORT AMProfileModule.ERROR_ID_VERSION_NOT_SUPPORT(402)} indicates version not support error.</li>
     * </ul>
     */
    ERROR_NUM_AM: RCTModule.ERROR_NUM_AM,
    /**
     * The error ID indicates parameter error(400).
     */
    ERROR_ID_ILLEGAL_ARGUMENT: RCTModule.ERROR_ID_ILLEGAL_ARGUMENT,
    /**
     * The error ID indicates version not support error(402).
     */
    ERROR_ID_VERSION_NOT_SUPPORT: RCTModule.ERROR_ID_VERSION_NOT_SUPPORT,
    /**
     * The key of error description.("description")<br/>
     * The value string will show the detail description of the error.
     */
    ERROR_DESCRIPTION_AM: RCTModule.ERROR_DESCRIPTION_AM,
    RESET_AM: RCTModule.RESET_AM,
    USERID_AM: RCTModule.USERID_AM,
    GET_USER_AGE_AM: RCTModule.GET_USER_AGE_AM,
    GET_USER_STEP_AM: RCTModule.GET_USER_STEP_AM,
    GET_USER_HEIGHT_AM: RCTModule.GET_USER_HEIGHT_AM,
    GET_USER_SEX_AM: RCTModule.GET_USER_SEX_AM,
    GET_USER_WEIGHT_AM: RCTModule.GET_USER_WEIGHT_AM,
    GET_USER_UNIT_AM: RCTModule.GET_USER_UNIT_AM,
    GET_USER_TARGET1_AM: RCTModule.GET_USER_TARGET1_AM,
    GET_USER_TARGET2_AM: RCTModule.GET_USER_TARGET2_AM,
    GET_USER_TARGET3_AM: RCTModule.GET_USER_TARGET3_AM,
    GET_USER_SWIMTARGET_AM: RCTModule.GET_USER_SWIMTARGET_AM,
    GET_ALARMNUM_AM: RCTModule.GET_ALARMNUM_AM,
    GET_ALARMNUM_ID_AM: RCTModule.GET_ALARMNUM_ID_AM,
    GET_ALARM_CLOCK_DETAIL: RCTModule.GET_ALARM_CLOCK_DETAIL,
    GET_ALARM_ID_AM: RCTModule.GET_ALARM_ID_AM,
    GET_ALARM_TIME_AM: RCTModule.GET_ALARM_TIME_AM,
    GET_ALARM_ISREPEAT_AM: RCTModule.GET_ALARM_ISREPEAT_AM,
    GET_ALARM_WEEK_AM: RCTModule.GET_ALARM_WEEK_AM,
    GET_ALARM_WEEK_SUNDAY_AM: RCTModule.GET_ALARM_WEEK_SUNDAY_AM,
    GET_ALARM_WEEK_MONDAY_AM: RCTModule.GET_ALARM_WEEK_MONDAY_AM,
    GET_ALARM_WEEK_TUESDAY_AM: RCTModule.GET_ALARM_WEEK_TUESDAY_AM,
    GET_ALARM_WEEK_WEDNESDAY_AM: RCTModule.GET_ALARM_WEEK_WEDNESDAY_AM,
    GET_ALARM_WEEK_THURSDAY_AM: RCTModule.GET_ALARM_WEEK_THURSDAY_AM,
    GET_ALARM_WEEK_FRIDAY_AM: RCTModule.GET_ALARM_WEEK_FRIDAY_AM,
    GET_ALARM_WEEK_SATURDAY_AM: RCTModule.GET_ALARM_WEEK_SATURDAY_AM,
    GET_ALARM_ISON_AM: RCTModule.GET_ALARM_ISON_AM,
    GET_ACTIVITY_REMIND_TIME_AM: RCTModule.GET_ACTIVITY_REMIND_TIME_AM,
    GET_ACTIVITY_REMIND_ISON_AM: RCTModule.GET_ACTIVITY_REMIND_ISON_AM,
    SYNC_ACTIVITY_DATA_AM: RCTModule.SYNC_ACTIVITY_DATA_AM,
    SYNC_ACTIVITY_DATA_TIME_AM: RCTModule.SYNC_ACTIVITY_DATA_TIME_AM,
    SYNC_ACTIVITY_DATA_STEP_AM: RCTModule.SYNC_ACTIVITY_DATA_STEP_AM,
    SYNC_ACTIVITY_DATA_STEP_LENGTH_AM: RCTModule.SYNC_ACTIVITY_DATA_STEP_LENGTH_AM,
    SYNC_ACTIVITY_DATA_CALORIE_AM: RCTModule.SYNC_ACTIVITY_DATA_CALORIE_AM,
    SYNC_ACTIVITY_EACH_DATA_AM: RCTModule.SYNC_ACTIVITY_EACH_DATA_AM,
    SYNC_SLEEP_DATA_AM: RCTModule.SYNC_SLEEP_DATA_AM,
    SYNC_SLEEP_DATA_TIME_AM: RCTModule.SYNC_SLEEP_DATA_TIME_AM,
    SYNC_SLEEP_DATA_LEVEL_AM: RCTModule.SYNC_SLEEP_DATA_LEVEL_AM,
    SYNC_SLEEP_EACH_DATA_AM: RCTModule.SYNC_SLEEP_EACH_DATA_AM,
    SYNC_STAGE_DATA_AM: RCTModule.SYNC_STAGE_DATA_AM,
    SYNC_STAGE_DATA_TYPE_AM: RCTModule.SYNC_STAGE_DATA_TYPE_AM,
    SYNC_STAGE_DATA_TYPE_WORKOUT_AM: RCTModule.SYNC_STAGE_DATA_TYPE_WORKOUT_AM,
    SYNC_STAGE_DATA_TYPE_SLEEP_AM: RCTModule.SYNC_STAGE_DATA_TYPE_SLEEP_AM,
    SYNC_STAGE_DATA_TYPE_SWIM_AM: RCTModule.SYNC_STAGE_DATA_TYPE_SWIM_AM,
    SYNC_STAGE_DATA_TYPE_PAGE_VIEW_SUMMARY: RCTModule.SYNC_STAGE_DATA_TYPE_PAGE_VIEW_SUMMARY,
    SYNC_STAGE_DATA_STOP_TIME_AM: RCTModule.SYNC_STAGE_DATA_STOP_TIME_AM,
    SYNC_STAGE_DATA_USED_TIME_AM: RCTModule.SYNC_STAGE_DATA_USED_TIME_AM,
    SYNC_STAGE_DATA_WORKOUT_STEP_AM: RCTModule.SYNC_STAGE_DATA_WORKOUT_STEP_AM,
    SYNC_STAGE_DATA_DISTANCE_AM: RCTModule.SYNC_STAGE_DATA_DISTANCE_AM,
    SYNC_STAGE_DATA_CALORIE_AM: RCTModule.SYNC_STAGE_DATA_CALORIE_AM,
    SYNC_STAGE_DATA_SLEEP_EFFICIENCY_AM: RCTModule.SYNC_STAGE_DATA_SLEEP_EFFICIENCY_AM,
    SYNC_STAGE_DATA_SLEEP_IS50MIN_AM: RCTModule.SYNC_STAGE_DATA_SLEEP_IS50MIN_AM,
    SYNC_STAGE_DATA_SWIM_STROKE_AM: RCTModule.SYNC_STAGE_DATA_SWIM_STROKE_AM,
    SYNC_STAGE_DATA_SWIM_PULL_TIMES_AM: RCTModule.SYNC_STAGE_DATA_SWIM_PULL_TIMES_AM,
    SYNC_STAGE_DATA_SWIM_TURNS_AM: RCTModule.SYNC_STAGE_DATA_SWIM_TURNS_AM,
    SYNC_STAGE_DATA_SWIMPOOL_LENGTH_AM: RCTModule.SYNC_STAGE_DATA_SWIMPOOL_LENGTH_AM,
    SYNC_STAGE_DATA_SWIM_CUTINDIF_AM: RCTModule.SYNC_STAGE_DATA_SWIM_CUTINDIF_AM,
    SYNC_STAGE_DATA_SWIM_CUTOUTDIF_AM: RCTModule.SYNC_STAGE_DATA_SWIM_CUTOUTDIF_AM,
    SYNC_STAGE_DATA_SWIM_PROCESSFLAG_AM: RCTModule.SYNC_STAGE_DATA_SWIM_PROCESSFLAG_AM,
    SYNC_STAGE_DATA_VIEW_SUMMARY_DATE_AM: RCTModule.SYNC_STAGE_DATA_VIEW_SUMMARY_DATE_AM,
    SYNC_STAGE_DATA_VIEW_SUMMARY_STEP_AM: RCTModule.SYNC_STAGE_DATA_VIEW_SUMMARY_STEP_AM,
    SYNC_STAGE_DATA_VIEW_SUMMARY_DISTANCE_AM: RCTModule.SYNC_STAGE_DATA_VIEW_SUMMARY_DISTANCE_AM,
    SYNC_STAGE_DATA_VIEW_SUMMARY_CALORIE_AM: RCTModule.SYNC_STAGE_DATA_VIEW_SUMMARY_CALORIE_AM,
    SYNC_STAGE_DATA_VIEW_SUMMARY_TARGET_AM: RCTModule.SYNC_STAGE_DATA_VIEW_SUMMARY_TARGET_AM,
    SYNC_STAGE_DATA_VIEW_SUMMARY_SWIM_AM: RCTModule.SYNC_STAGE_DATA_VIEW_SUMMARY_SWIM_AM,
    QUERY_STATE_AM: RCTModule.QUERY_STATE_AM,
    QUERY_BATTERY_AM: RCTModule.QUERY_BATTERY_AM,
    SYNC_REAL_STEP_AM: RCTModule.SYNC_REAL_STEP_AM,
    SYNC_REAL_CALORIE_AM: RCTModule.SYNC_REAL_CALORIE_AM,
    SYNC_REAL_TOTALCALORIE_AM: RCTModule.SYNC_REAL_TOTALCALORIE_AM,
    GET_SWIMLANE_LENGTH_AM: RCTModule.GET_SWIMLANE_LENGTH_AM,
    GET_SWIM_SWITCH_AM: RCTModule.GET_SWIM_SWITCH_AM,
    GET_SWIM_CUTOUT_HOUR_AM: RCTModule.GET_SWIM_CUTOUT_HOUR_AM,
    GET_SWIM_CUTOUT_MINUTE_AM: RCTModule.GET_SWIM_CUTOUT_MINUTE_AM,
    GET_SWIM_UNIT_AM: RCTModule.GET_SWIM_UNIT_AM,
    GET_RANDOM_AM: RCTModule.GET_RANDOM_AM,
    AM_SWITCH_OPEN: RCTModule.AM_SWITCH_OPEN,
    AM_SWITCH_CLOSE: RCTModule.AM_SWITCH_CLOSE,
    AM_SWITCH_REPEAT: RCTModule.AM_SWITCH_REPEAT,
    AM_SEITCH_NOT_REPEAT: RCTModule.AM_SEITCH_NOT_REPEAT,
    AM_SET_MALE: RCTModule.AM_SET_MALE,
    AM_SET_FEMALE: RCTModule.AM_SET_FEMALE,
    AM_SET_UNIT_METRIC: RCTModule.AM_SET_UNIT_METRIC,
    AM_SET_UNIT_IMPERIAL_STANDARD: RCTModule.AM_SET_UNIT_IMPERIAL_STANDARD,
    AM_SET_12_HOUR_MODE: RCTModule.AM_SET_12_HOUR_MODE,
    AM_SET_24_HOUR_MODE: RCTModule.AM_SET_24_HOUR_MODE,
    AM_SET_EUROPE_12_HOUR_MODE: RCTModule.AM_SET_EUROPE_12_HOUR_MODE,
    AM_SET_EUROPE_24_HOUR_MODE: RCTModule.AM_SET_EUROPE_24_HOUR_MODE,
    AM_SET_EXCEPT_EUROPE_12_HOUR_MODE: RCTModule.AM_SET_EXCEPT_EUROPE_12_HOUR_MODE,
    AM_SET_EXCEPT_EUROPE_24_HOUR_MODE: RCTModule.AM_SET_EXCEPT_EUROPE_24_HOUR_MODE,
    GET_HOUR_MODE_AM: RCTModule.GET_HOUR_MODE_AM,
    AM_DEVICE_MODE_SLEEP: RCTModule.AM_DEVICE_MODE_SLEEP,
    AM_DEVICE_MODE_ACTIVITY: RCTModule.AM_DEVICE_MODE_ACTIVITY,
    AM_DEVICE_MODE_FLIGHT: RCTModule.AM_DEVICE_MODE_FLIGHT,
    AM_DEVICE_MODE_DRIVING: RCTModule.AM_DEVICE_MODE_DRIVING,
    CLOUD_SEARCH_AM: RCTModule.CLOUD_SEARCH_AM,
    DATAID: RCTModule.DATAID,
    GET_PICTURE_AM: RCTModule.GET_PICTURE_AM
}