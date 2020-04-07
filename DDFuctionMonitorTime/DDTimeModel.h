//
//  DDTimeModel.h
//  DDFuctionMonitorTime
//
//  Created by apple on 2020/4/7.
//  Copyright © 2020 DD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDTimeModel : NSObject

@property (nonatomic, copy) NSString * functionName;         // 方法名称
@property (nonatomic, copy) NSString * functionAddress;      // 方法地址
@property (nonatomic, assign) NSTimeInterval consumeTime;    // 消耗时间

@end

NS_ASSUME_NONNULL_END
