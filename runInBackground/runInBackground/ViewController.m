//
//  ViewController.m
//  runInBackground
//
//  Created by coohua on 15/7/7.
//  Copyright (c) 2015年 cn.coohua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 用到通知，第一次运行时需要用户允许
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}
- (void)viewDidAppear:(BOOL)animated {
    // 异步执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self background];
    });
}

- (void)background {
    
    int i = 0;
    
    // 无限循环
    while (1) {
        // 延时1秒
        [NSThread sleepForTimeInterval:1];
        [UIApplication sharedApplication].applicationIconBadgeNumber = i++;
    }
}

@end
