//
//  RunInBackground.h
//  audioBg
//
//  Created by coohua on 15/7/2.
//  Copyright (c) 2015年 cn.coohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunInBackground : NSObject

+ (instancetype)sharedBg;

// 调用此方法后，程序进入后台也不会死掉
- (void)startRunInbackGround;

// 停止播放音乐
- (void)stopAudioPlay;
@end

/* 使用方法
 分为5步：
 1 添加文件runInBg目录下的文件
 2 包含头文件   #import "RunInBackground.h"
 3 使用全局队列实现异步执行
 4 使用单利调用startRunInbackGround方法
 5 开启循环
 停止时调用[[RunInBackground sharedBg] stopAudioPlay];即可
 
 
 ********************************以下为具体例子***********************************
 在进入后台时可以调用startRunInbackGround方法
- (void)applicationDidEnterBackground:(UIApplication *)application {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[RunInBackground sharedBg] startRunInbackGround];
        [[NSRunLoop currentRunLoop] run];
    });
}
 前台时停止播放
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[RunInBackground sharedBg] stopAudioPlay];
}


*/