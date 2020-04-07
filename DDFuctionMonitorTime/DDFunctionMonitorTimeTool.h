//
//  DDFunctionMonitorTimeTool.h
//  DDFuctionMonitorTime
//
//  Created by apple on 2020/4/7.
//  Copyright © 2020 DD. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DD_TIME_INTERVAL   0.01

NS_ASSUME_NONNULL_BEGIN

@interface DDFunctionMonitorTimeTool : NSObject

+ (void)startMonitor;
+ (void)stopMonitor;

+ (NSDictionary *)backtraceMapOfMainThread;

@end

NS_ASSUME_NONNULL_END
