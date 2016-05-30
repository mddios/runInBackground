# 描述
- 利用Audio实现程序后台运行
- 例程程序退到后台applicationIconBadgeNumber会1s加1


## 使用方法
分为5步：
- 1. 添加文件runInBg目录下的文件
- 2. 包含头文件   #import "RunInBackground.h"
- 3. 使用全局队列实现异步执行
- 4. 使用单利调用startRunInbackGround方法
- 5. 开启循环
- 6. 在Info.plist中添加UIBackgroundModes键audio（必须添加）
- 停止时调用[[RunInBackground sharedBg] stopAudioPlay];即可


********************************以下为具体例子***********************************

在进入后台时可以调用startRunInbackGround方法，在AppDelegate类增加isRun成员变量
- (void)applicationDidEnterBackground:(UIApplication *)application {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        isRun = YES;
        [[RunInBackground sharedBg] startRunInbackGround];
        [[NSRunLoop currentRunLoop] run];
    });
}

前台时停止播放
- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (isRun) {
        [[RunInBackground sharedBg] stopAudioPlay];
    }
}



