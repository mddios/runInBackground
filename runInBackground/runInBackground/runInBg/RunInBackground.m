//
//  RunInBackground.m
//  audioBg
//
//  Created by coohua on 15/7/2.
//  Copyright (c) 2015年 cn.coohua. All rights reserved.
//

#import "RunInBackground.h"
#import <AVFoundation/AVFoundation.h>

@interface RunInBackground ()


@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSTimer *audioTimer;

@end

@implementation RunInBackground

/// 提供一个单例
+ (instancetype)sharedBg {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
/// 重写init方法，初始化音乐文件
- (instancetype)init {
    if (self = [super init]) {
        [self setUpAudioSession];
        
        // 播放文件
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"mysong" ofType:@"mp3"];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:filePath];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        [self.audioPlayer prepareToPlay];
        // 0.0~1.0,默认为1.0
        self.audioPlayer.volume = 0.01;
        // 循环播放
        self.audioPlayer.numberOfLoops = -1;
    }
    return self;
}
/// 添加一个定时器，退到后台后会在10秒左右的时间停止运行程序，在每一段时间内(暂时设为5)应播放一次音乐。为了省电音乐应尽可能短。
- (void)startRunInbackGround {
    // 调用audioStartPlay方法
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:5.0 target:self selector:@selector(startAudioPlay) userInfo:nil repeats:YES];
    
    // 如果不是主线程循环需要开启循环
//    if ([NSRunLoop currentRunLoop] != [NSRunLoop mainRunLoop]) {
//        [[NSRunLoop currentRunLoop] run];
//    }
    
    // 默认
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.audioTimer = timer;
}

- (void)startAudioPlay {
    // 异步执行
    [self.audioPlayer play];
}
- (void)stopAudioPlay {
    // 关闭定时器即可
    [self.audioTimer invalidate];
    // 保证释放
    self.audioTimer = nil;
}
- (void)setUpAudioSession {
    // 新建AudioSession会话
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    // 设置后台播放
    NSError *error = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&error];
    
    if (error) {
        NSLog(@"Error setCategory AVAudioSession: %@", error);
    }
    
    NSError *activeSetError = nil;
    // 启动AudioSession，如果一个前台app正在播放音频则可能启动失败
    [audioSession setActive:YES error:&activeSetError];
    if (activeSetError) {
        NSLog(@"Error activating AVAudioSession: %@", activeSetError);
    }
}

@end


