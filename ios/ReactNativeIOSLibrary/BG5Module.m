//
//  BG5Module.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/11/23.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "BG5Module.h"
#import "BGProfileModule.h"
#import "BGMacroFile.h"
#import "BG5Controller.h"
#import "BG5.h"

#define EVENT_NOTIFY @"event_notify_bg5"

@implementation BG5Module

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport
{
    return @{
             @"Event_Notify":@"event_notify_bg5",
             
             };
}


#pragma mark
#pragma mark - Init
-(id)init
{
    if (self=[super init])
    {
        
        [BG5Controller shareIHBg5Controller];
        
    }
    return self;
}



-(BG5*)getBG5WithMac:(NSString*)mac{
    
    BG5Controller *controller = [BG5Controller shareIHBg5Controller];
    NSArray *BGDeviceArray = [controller getAllCurrentBG5Instace];
    
    for(BG5 *tempBG5 in BGDeviceArray){
        if([mac isEqualToString:tempBG5.serialNumber]){
            
            tempBG5.reactNativeFlg = @YES; //reactNative开关，YES时不走SDK认证等，NO走SDK所有流程。
            return tempBG5;
            break;
        }
    }
    
    return nil;
}


#pragma mark
#pragma mark - Method

RCT_EXPORT_METHOD(codeAnalysis:(nonnull NSString *)mac :(nonnull NSString *)QR){
    
    
    if ([self getBG5WithMac:mac]!=nil) {

        NSDictionary *codeDic = [[self getBG5WithMac:mac]codeStripStrAnalysis:mac];
        
        NSDate *tempDate = [codeDic objectForKey:@"DueDate"];
        
        //将时间格式转化成字符串，适配plugin和react native
        NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
        [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeZone *dongBaTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
        [mydateFormatter setTimeZone:dongBaTimeZone];
        NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
        
        NSNumber *bottleID = [codeDic objectForKey:@"BottleID"];
        NSNumber *remainNum = [codeDic objectForKey:@"StripNum"];
        
        NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_code_analysis_bg",@"stripNum":remainNum,@"expiretime":dateStr,@"bottleid":bottleID};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }else{
        
        NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":@100};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
}



RCT_EXPORT_METHOD(holdLink:(nonnull NSString *)mac){
    
    
    if ([self getBG5WithMac:mac]!=nil) {
        [[self getBG5WithMac:mac]commandKeepConnect:^(BOOL sendOk) {
            
           NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_keep_link",@"keep_link":@true};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        } DisposeErrorBlock:^(NSNumber *errorID) {
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":errorID};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        }];
    }else{
        
        NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":@100};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
}

#pragma mark
#pragma mark - Method


RCT_EXPORT_METHOD(getBattery:(nonnull NSString *)mac){
    
    
    if ([self getBG5WithMac:mac]!=nil) {
        
        [[self getBG5WithMac:mac] commandQueryBattery:^(NSNumber *energy) {
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_battery_bg",@"battery":energy};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DisposeErrorBlock:^(NSNumber *errorID) {
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":errorID};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        }];
        
    }else{
        
        NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":@100 };
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
}

RCT_EXPORT_METHOD(setTime:(nonnull NSString *)mac){
    
    
    if ([self getBG5WithMac:mac]!=nil) {
        
        [[self getBG5WithMac:mac] commandBGSetTime:^(BOOL setResult) {
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_set_time",@"set_time":@true};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":errorID};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        }];
    }else{
        
        NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":@100 };
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
}


RCT_EXPORT_METHOD(setUnit:(nonnull NSString *)mac :(nonnull NSNumber *)type){
    
    if ([self getBG5WithMac:mac]!=nil) {
        
        BGUnit tempUnit = BGUnit_mmolPL;
        if ([type isEqual:@1]) {
            tempUnit = BGUnit_mmolPL;
        }
        else if([type isEqual:@2])
        {
            tempUnit = BGUnit_mgPmL;
        }
        else
        {
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":@400 };
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            return;
        }
        
        [[self getBG5WithMac:mac] commandBGSetUnit:tempUnit DisposeSetUnitResult:^(BOOL setResult) {
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_set_unit",@"set_unit":@true};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":errorID};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        }];
        
    }else{
        
        NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":@100 };
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
    
}


RCT_EXPORT_METHOD(getBottleId:(nonnull NSString *)mac){
    
    
    if ([self getBG5WithMac:mac]!=nil) {
        [[self getBG5WithMac:mac]commandBGGetBottleID:^(NSNumber *bottleID) {
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_get_bottleid",@"bottleid":bottleID};
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":errorID};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        }];
        
    }else{
        
        NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":@100 };
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
}


RCT_EXPORT_METHOD(startMeasure:(nonnull NSString *)mac :(nonnull NSNumber *)testType){
    
    
    if ([self getBG5WithMac:mac]!=nil) {
        
        BGMeasureMode testModel = BGMeasureMode_Blood;
        if([testType isEqual: @1])
        {
            testModel = BGMeasureMode_Blood;
        }
        else if([testType isEqual: @2])
        {
            testModel = BGMeasureMode_NoBlood;
        }
        else
        {
            //输入参数错误
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":@400};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        }
        
        [[self getBG5WithMac:mac]commandCreateBGtestModel:testModel DisposeBGStripInBlock:^(BOOL stripIn) {
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_strip_in_bg"};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DisposeBGBloodBlock:^(BOOL blood) {
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_blood_bg"};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DisposeBGResultBlock:^(NSDictionary *result) {
            
            NSDate *measureDate = [result objectForKey:@"Date"];
            
            //将时间格式转化成字符串，适配plugin和react native
            NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
            [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateStr = [mydateFormatter stringFromDate:measureDate];
            
            NSDictionary *resultDic = [NSDictionary dictionaryWithObjectsAndKeys:dateStr,@"date",[result objectForKey:@"Result"],@"value",[result objectForKey:@"dataID"],@"dataID", nil];
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_result_bg",@"result":resultDic};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DisposeBGTestModelBlock:^(BGMeasureMode mode) {
            
            NSNumber *modelNum = @1;
            if (mode == BGMeasureMode_Blood) {
                modelNum = @1;
            }else
            {
                modelNum = @2;
            }
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_test_model_bg",@"type":modelNum};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":errorID};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        }];
        
        
    }else{
        
        NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":@100 };
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    }
    
}

RCT_EXPORT_METHOD(getOfflineData:(nonnull NSString *)mac){
    
    
    if ([self getBG5WithMac:mac]!=nil) {
        [[self getBG5WithMac:mac]commandTransferMemorryData:^(NSNumber *dataCount) {
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_historicalnum_bg",@"count":dataCount};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DisposeBGHistoryData:^(NSDictionary *historyDataDic) {
            
            NSArray *historyArr = [NSArray arrayWithArray:[historyDataDic objectForKey:@"ResultList"]];
            NSMutableArray * tempArr = [[NSMutableArray alloc]init];
            
            for(NSDictionary *history in historyArr)
            {
                NSDate *tempDate = [history objectForKey:@"Date"];
                
                //将时间格式转化成字符串，适配plugin和react native
                NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
                
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dateStr,@"date",[history objectForKey:@"Result"],@"value",[history objectForKey:@"dataID"],@"dataID", nil];
                
                [tempArr addObject:dic];
            }
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_historicaldata_bg",@"his_data_bg":[NSArray arrayWithArray:tempArr]};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":errorID};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        }];
        
    }else{
        
        NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":@100 };
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
}
RCT_EXPORT_METHOD(deleteOfflineData:(nonnull NSString *)mac){
    
    
    if ([self getBG5WithMac:mac]!=nil) {
        [[self getBG5WithMac:mac]commandDeleteMemorryData:^(BOOL deleteOk) {
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_delete_historical_data",@"delete_historical_data":@true};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        }];
        
    }else{
        
        
        NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":@100 };
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    }
    
}
RCT_EXPORT_METHOD(setBottleMessageWithInfo:(nonnull NSString *)mac :(nonnull NSNumber *)codeType :(nonnull NSNumber *)testType :(nonnull NSString *)QR: (nonnull NSNumber *)stripNum :(nonnull NSString *)overDate){
    
    
    if ([self getBG5WithMac:mac]!=nil) {
        
        if (QR ==nil || QR.length<30) {
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":@400};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
            return;
        }
        
        //code的截止时期是东八区的时间
        NSDateFormatter *dongBaFormatter=nil;
        if (dongBaFormatter == nil) {
            dongBaFormatter = [[NSDateFormatter alloc] init];
            NSTimeZone *dongBaTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
            [dongBaFormatter setTimeZone:dongBaTimeZone];
            [dongBaFormatter setDateFormat:@"yyyy-MM-dd"];
            NSCalendar *canlendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            [dongBaFormatter setCalendar:canlendar];
        }
        
        NSDate *dueDate = [dongBaFormatter dateFromString:overDate];//过期时间
        
        NSDictionary *codeDic = [[self getBG5WithMac:mac]codeStripStrAnalysis:QR];
        NSNumber *bottleID = [codeDic objectForKey:@"BottleID"];
        
        BGMeasureMode *bgMeasureModel = BGMeasureMode_Blood;
        if(codeType.integerValue == 2)
        {
            bgMeasureModel = BGMeasureMode_NoBlood;
        }
        
        BGCodeMode *bgCodeModel =BGCodeMode_GOD;
        if(codeType.integerValue == 2)
        {
            bgCodeModel = BGCodeMode_GDH;
        }
        
        [[self getBG5WithMac:mac]commandSendBGCodeWithMeasureType:bgMeasureModel CodeType:bgCodeModel CodeString:QR bottleID:bottleID validDate:dueDate remainNum:stripNum DisposeBGSendCodeBlock:^(BOOL sendOk) {
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_set_bottle_message_success",@"set_bottle_message":@true};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DisposeBGStartModel:^(BGOpenMode mode) {
            
            NSNumber *openModelNum = @1;
            if(mode == BGOpenMode_Strip)
            {
                //插条开机
                openModelNum = @1;
                
                [[self getBG5WithMac:mac]commandCreateBGtestStripInBlock:^(BOOL stripIn) {
                    NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_strip_in_bg"};
                    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
                    
                } DisposeBGBloodBlock:^(BOOL blood) {
                    
                    NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_blood_bg"};
                    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
                    
                } DisposeBGResultBlock:^(NSDictionary *result) {
                    
                    NSDate *measureDate = [result objectForKey:@"Date"];
                    
                    //将时间格式转化成字符串，适配plugin和react native
                    NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                    [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *dateStr = [mydateFormatter stringFromDate:measureDate];

                    
                    NSDictionary *resultDic = [NSDictionary dictionaryWithObjectsAndKeys:dateStr,@"date",[result objectForKey:@"Result"],@"value",[result objectForKey:@"dataID"],@"dataID", nil];
                    
                    NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_result_bg",@"result":resultDic};
                    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
                    
                } DisposeBGTestModelBlock:^(BGMeasureMode mode) {
                    
                    NSNumber *modelNum = @1;
                    if (mode == BGMeasureMode_Blood) {
                        //血液测量
                        modelNum = @1;
                    }else
                    {
                        //质控液测量
                        modelNum = @2;
                    }
                    NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_test_model_bg",@"type":modelNum};
                    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
                    
                } DisposeBGErrorBlock:^(NSNumber *errorID) {
                    NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":errorID};
                    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
                }];

            }
            else
            {
                //按键开机
                openModelNum = @2;
            }
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_open_model_bg",@"type":openModelNum};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":errorID};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        }];
        
        
    }else{
        
        NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":@100 };
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
}


RCT_EXPORT_METHOD(getBottleMessage:(nonnull NSString *)mac){
    
    
    if ([self getBG5WithMac:mac]!=nil) {
        [[self getBG5WithMac:mac]commandReadBGCodeDic:^(NSDictionary *codeDic) {
            
            NSDate *tempDate = [codeDic objectForKey:@"Date"];
            
            //将时间格式转化成字符串，适配plugin和react native
            NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
            [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSTimeZone *dongBaTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
            [mydateFormatter setTimeZone:dongBaTimeZone];
            NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
            
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_get_codeinfo",@"expiretime":dateStr,@"usenum":[codeDic objectForKey:@"Strips"]};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":errorID};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        }];
        
    }else{
        
        NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"action_measure_error",@"error_num":@100 };
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
}


@end
