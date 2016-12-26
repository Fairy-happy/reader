//
//  ReaderTool.h
//  reader
//
//  Created by fairy on 16/12/22.
//  Copyright © 2016年 fairy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BatteryMonitorBlock)(CGFloat batteryLevel);
typedef void (^TimeMonitorBlock)(NSDate *currentDate);

@interface ReaderTool : NSObject

-(void)statMonitorBatteryWithBlock:(BatteryMonitorBlock)block;

-(void)stopMonitorBattery;

-(void)startMonitorTimeWithBlock:(TimeMonitorBlock)block;

-(void)stopMonitorTime;


@end
