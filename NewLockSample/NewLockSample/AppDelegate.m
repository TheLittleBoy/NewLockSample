//
//  AppDelegate.m
//  NewLockSample
//
//  Created by MAC_AO on 14/11/30.
//  Copyright (c) 2014年 MAC_AO. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

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
    
    // 手势解锁相关
    NSString* pswd = [LLLockPassword loadLockPassword];
    if (pswd) {
        [self showLLLockViewController:LLLockViewTypeCheck];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //程序首次启动的时候不会调用此方法！
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // 手势解锁相关
    NSString* pswd = [LLLockPassword loadLockPassword];
    if (pswd) {
        [self showLLLockViewController:LLLockViewTypeCheck];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 弹出手势解锁密码输入框
- (void)showLLLockViewController:(LLLockViewType)type
{
    if(self.window.rootViewController.presentingViewController == nil){
        
        LLLog(@"root = %@", self.window.rootViewController.class);
        LLLog(@"lockVc isBeingPresented = %d", [self.lockVc isBeingPresented]);
        
        self.lockVc = [[LLLockViewController alloc] init];
        self.lockVc.nLockViewType = type;
        
        self.lockVc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        [self.window.rootViewController presentViewController:self.lockVc animated:NO completion:^{
        }];
        LLLog(@"创建了一个pop=%@", self.lockVc);
    }
}

@end
