//
//  ViewController.m
//  DDFuctionMonitorTime
//
//  Created by apple on 2020/4/7.
//  Copyright © 2020 DD. All rights reserved.
//

#import "ViewController.h"
#import "DDFunctionMonitorTimeTool.h"
#import "DDTimeModel.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showBacktrace];
    [self endBacktrace];
}

- (void)showBacktrace
{
    NSDictionary *callStackDict = [DDFunctionMonitorTimeTool backtraceMapOfMainThread];

    NSMutableString * resultString = [NSMutableString stringWithFormat:@""];
    for (NSString * key in callStackDict.allKeys) {
        DDTimeModel * model = [callStackDict objectForKey:key];
        if (model.functionName && model.consumeTime > DD_TIME_INTERVAL) {
            [resultString appendFormat:@"%@的耗时为：%0.2f \n\n\n",model.functionName,model.consumeTime];
        }
    }
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"主线程中所有的方法耗时(误差0.1s)：" message:[resultString copy] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [alertVC addAction:confirmAction];
    alertVC.modalPresentationStyle =  UIModalPresentationFullScreen;
    [self presentViewController:alertVC animated:nil completion:nil];
}

- (void)endBacktrace
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DD_TIME_INTERVAL * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DDFunctionMonitorTimeTool stopMonitor];
    });
}


@end
