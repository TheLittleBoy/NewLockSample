//
//  ViewController.h
//  NewLockSample
//
//  Created by MAC_AO on 14/11/30.
//  Copyright (c) 2014年 MAC_AO. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"

@interface FirstViewController ()
{
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lockButtonPressed:(id)sender {
    
    if ([LLLockPassword loadLockPassword]) {
        AppDelegate* ad = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [ad showLLLockViewController:LLLockViewTypeCheck];
    }else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"请开启密码锁定"
                                                       delegate:nil
                                              cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}


@end
