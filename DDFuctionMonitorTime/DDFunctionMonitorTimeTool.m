//
//  DDFunctionMonitorTimeTool.m
//  DDFuctionMonitorTime
//
//  Created by apple on 2020/4/7.
//  Copyright © 2020 DD. All rights reserved.
//

#import "DDFunctionMonitorTimeTool.h"
#import "BSBacktraceLogger.h"
#import "DDTimeModel.h"


static dispatch_source_t timer;
static NSMutableDictionary *stackDictionary;

@implementation DDFunctionMonitorTimeTool

+ (void)startMonitor
{
    if (!stackDictionary) {
        stackDictionary = @{}.mutableCopy;
    }
    if (!timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    }
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), DD_TIME_INTERVAL * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(timer, ^{
        NSDictionary *mainThreadCallStack = [BSBacktraceLogger bs_backtraceMapOfMainThread];
        
        for (NSString *functionAddress in mainThreadCallStack.allKeys) {
            DDTimeModel *timeModel = [stackDictionary objectForKey:functionAddress];
            if (!timeModel) {
                NSString *functionName = [mainThreadCallStack objectForKey:functionAddress];
                timeModel = [[DDTimeModel alloc] init];
                timeModel.consumeTime = DD_TIME_INTERVAL;
                timeModel.functionAddress = functionAddress;
                timeModel.functionName = functionName;
                [stackDictionary setObject:timeModel forKey:functionAddress];

            } else {
                timeModel.consumeTime += DD_TIME_INTERVAL;
            }
        }
    });
    dispatch_resume(timer);
}

+ (void)stopMonitor
{
    if (timer) {
        dispatch_source_cancel(timer);
        timer = nil;
    }
}

+ (NSDictionary *)backtraceMapOfMainThread;
{
    return stackDictionary;
}

@end
