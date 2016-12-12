//
//  BP7SModule.m
//  ReactNativeIOSLibrary
//
//  Created by Liu Yanbo on 2016/12/05.
//  Copyright © 2016年 Liu Yanbo. All rights reserved.
//

#import "BP7SModule.h"
#import "BPProfileModule.h"
#import "BPMacroFile.h"
#import "BP7SController.h"
#import "BP7S.h"
@implementation BP7SModule
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport
{
    return @{
             @"Event_Notify":@"BP7S.MODULE.NOTIFY",
             
             };
}


-(BP7S*)getDeviceWithMac:(NSString*)mac{
    
    BP7SController *controller = [BP7SController shareBP7SController];
    NSArray *bpDeviceArray = [controller getAllCurrentBP7SInstace];
    
    for(BP7S *tempDevice in bpDeviceArray){
        if([mac isEqualToString:tempDevice.serialNumber]){
            
            return tempDevice;
        }
    }
    
    return nil;
}


#pragma mark - Method

RCT_EXPORT_METHOD(getFunctionInfo:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        [[self getDeviceWithMac:mac] commandFounction:^(NSDictionary *dic) {
            
            NSDictionary* response = @{
                                       kACTION:kACTION_FUNCTION_INFORMATION_BP,
                                       kFUNCTION_IS_UPAIR_MEASURE:dic[@"upAirMeasureFlg"],
                                       kFUNCTION_IS_ARM_MEASURE:dic[@"armMeasureFlg"],
                                       kFUNCTION_HAVE_ANGLE_SENSOR:dic[@"haveAngleSensor"],
                                       kFUNCTION_HAVE_OFFLINE:dic[@"haveOffline"],
                                       kFUNCTION_HAVE_ANGLE_SETTING:dic[@"haveAngleSet"],
                                       kFUNCTION_IS_MULTI_UPLOAD:dic[@"mutableUpload"],
                                       kFUNCTION_HAVE_SELF_UPDATE:dic[@"selfUpdate"],
                                       kFUNCTION_HAVE_HSD:dic[@"haveHSD"]
                                       };
            [self sendEventWithDict:response];
        } errorBlock:^(BPDeviceError error) {
            [self sendErrorWithCode:error];
        }];
    }else{
        NSLog(@"error %d",BPDidDisconnect);
        [self sendErrorWithCode:BPDidDisconnect];
    }
    
    
}

//getOffLineNum
RCT_EXPORT_METHOD(getOffLineNum:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        [[self getDeviceWithMac:mac] commandTransferMemorytotalCount:^(NSNumber *num) {
            NSDictionary* response = @{
                                       kACTION:kACTION_HISTORICAL_NUM_BP,
                                       kHISTORICAL_NUM_BP:num,
                                       };
            [self sendEventWithDict:response];

        } errorBlock:^(BPDeviceError error) {
            [self sendErrorWithCode:error];
        }];
    }else{
        NSLog(@"error %d",BPDidDisconnect);
        [self sendErrorWithCode:BPDidDisconnect];
    }
    
    
}

//getOffLineData
RCT_EXPORT_METHOD(getOffLineData:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        [[self getDeviceWithMac:mac] commandTransferMemoryDataWithUser:nil clientID:nil clientSecret:nil Authentication:^(UserAuthenResult result) {
            NSLog(@"authen %d",result );
            if (result != UserAuthen_LoginSuccess) {
                [self sendErrorWithCode:result];
            }
        } totalCount:^(NSNumber *num) {
            NSDictionary* response = @{
                                       kACTION:kACTION_HISTORICAL_NUM_BP,
                                       kHISTORICAL_NUM_BP:num,
                                       };
            [self sendEventWithDict:response];
        } pregress:^(NSNumber *pregress) {
            NSLog(@"pregress %@",pregress);
        } dataArray:^(NSArray *array) {
            NSLog(@"dataArray %@",array);
            NSDictionary* response = @{
                                       kACTION:kACTION_HISTORICAL_DATA_BP,
                                       kHISTORICAL_DATA_BP:array,
                                       };
            [self sendEventWithDict:response];
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error %d",error);
            [self sendErrorWithCode:error];
        }];
    }else{
        NSLog(@"error %d",BPDidDisconnect);
        [self sendErrorWithCode:BPDidDisconnect];
    }
    
    
}
//getBattery
RCT_EXPORT_METHOD(getBattery:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        [[self getDeviceWithMac:mac] commandEnergy:^(NSNumber *energyValue) {
            NSLog(@"energyValue %@",energyValue);
            NSDictionary* response = @{
                                       kACTION:kACTION_BATTERY_BP,
                                       kBATTERY_BP:energyValue,
                                       };
            [self sendEventWithDict:response];
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error %d",error);
            [self sendErrorWithCode:error];
        }];
    }else{
        NSLog(@"error %d",BPDidDisconnect);
        [self sendErrorWithCode:BPDidDisconnect];
    }
    
    
}
//setUnit
RCT_EXPORT_METHOD(setUnit:(nonnull NSString *)mac unit:(nonnull NSNumber*)unit){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        [[self getDeviceWithMac:mac] commandSetUnit:[unit integerValue] > 0 ? @"kPa" : @"mmHg" errorBlock:^(BPDeviceError error) {
            NSLog(@"error %d",error);
            [self sendErrorWithCode:error];
        }];
    }else{
        NSLog(@"error %d",BPDidDisconnect);
        [self sendErrorWithCode:BPDidDisconnect];
    }
    
    
}
//angleSet
RCT_EXPORT_METHOD(angleSet:(nonnull NSString *)mac hl:(nonnull NSNumber*)hl ll:(nonnull NSNumber*)ll hr:(nonnull NSNumber*)hr lr:(nonnull NSNumber*)lr){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        NSDictionary* dict = @{
                               @"highAngleForLeft":hl,
                                @"lowAngleForLeft":ll,
                               @"highAngleForRight":hr,
                               @"lowAngleForRight":lr
                               };
        [[self getDeviceWithMac:mac] commandSetAngle:dict errorBlock:^(BPDeviceError error) {
            NSLog(@"error %d",error);
            [self sendErrorWithCode:error];
        }];
    }else{
        NSLog(@"error %d",BPDidDisconnect);
        [self sendErrorWithCode:BPDidDisconnect];
    }
    
    
}

RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        [[self getDeviceWithMac:mac] commandDisconnectDevice];
    }else{
        NSLog(@"error %d",BPDidDisconnect);
        [self sendErrorWithCode:BPDidDisconnect];
    }
    
    
}

- (void)sendErrorWithCode:(NSInteger)errorCode{
    [self sendEventWithDict:@{kACTION:kACTION_ERROR_BP,kERROR_NUM_BP:@(errorCode)}];
}

- (void)sendEventWithDict:(NSDictionary*)dict{
    [self.bridge.eventDispatcher sendDeviceEventWithName:@"BP7S.MODULE.NOTIFY"  body:dict];
}




@end
