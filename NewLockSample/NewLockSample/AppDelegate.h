//
//  AppDelegate.h
//  NewLockSample
//
//  Created by MAC_AO on 14/11/30.
//  Copyright (c) 2014年 MAC_AO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLLockViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// 手势解锁相关
@property (strong, nonatomic) LLLockViewController* lockVc; // 添加解锁界面
- (void)showLLLockViewController:(LLLockViewType)type;

@end

