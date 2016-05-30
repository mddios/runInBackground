//
//  AppDelegate.m
//  audioBg
//
//  Created by coohua on 15/7/2.
//  Copyright (c) 2015年 cn.coohua. All rights reserved.
//

#import "AppDelegate.h"
#import "RunInBackground.h"
@interface AppDelegate ()
{
    /// 用来标识音乐是否运行，防止stopAudioPlay在音乐没有打开时被调用
    BOOL isRun;
}

@property (nonatomic, assign) NSThread *thread;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        isRun = YES;
        [[RunInBackground sharedBg] startRunInbackGround];
        [[NSRunLoop currentRunLoop] run];
        self.thread = [NSThread currentThread];
    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (isRun) {
        [[RunInBackground sharedBg] stopAudioPlay];
    }
    if (![self.thread isMainThread]) {
        //        [self.thread cancel];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
