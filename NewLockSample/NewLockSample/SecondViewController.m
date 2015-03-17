//
//  ViewController.h
//  NewLockSample
//
//  Created by MAC_AO on 14/11/30.
//  Copyright (c) 2014年 MAC_AO. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"

#define kLableArray @[@"创建密码", @"修改密码", @"清除密码"]

@interface SecondViewController ()
{
    int numberSessions;
}
@property (weak, nonatomic) IBOutlet UITableView *settingTableView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([LLLockPassword loadLockPassword]) {
        numberSessions = 2;
    } else {
        numberSessions = 1;
    }
    [self.settingTableView reloadData]; // ios6需要不然不刷新，8不要，7未验证
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openTheLock:(UISwitch *)st
{
    if (st.on) {
        numberSessions = 2;
    }else
    {
        numberSessions = 1;
        [LLLockPassword saveLockPassword:nil];
    }
    
    [self.settingTableView reloadData];
}
#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return numberSessions;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ident = @"SettingCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (![cell viewWithTag:101]) {
            UISwitch * st = [[UISwitch alloc]initWithFrame:CGRectMake(260, 6, 60, 40)];
            [st addTarget:self action:@selector(openTheLock:) forControlEvents:UIControlEventValueChanged];
            st.on = numberSessions == 2;
            st.tag = 101;
            [cell addSubview:st];
            cell.textLabel.text = @"开启密码锁定";
        }else
        {
            UISwitch * st = (UISwitch *)[cell viewWithTag:101];
            st.on = numberSessions == 2;
        }
    }else{
        if ([LLLockPassword loadLockPassword]) {
            cell.textLabel.text = kLableArray[1];
        }else
        {
            cell.textLabel.text = kLableArray[0];
        }
        
        cell.clipsToBounds = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        if ([cell.textLabel.text isEqualToString:kLableArray[0]]) {
            [self showLLLockViewController:LLLockViewTypeCreate];
        }else if ([cell.textLabel.text isEqualToString:kLableArray[1]])
        {
            [self showLLLockViewController:LLLockViewTypeModify];
        }
    }
}

-(void)showLLLockViewController:(LLLockViewType)type
{
    LLLockViewController * lockVc = [[LLLockViewController alloc]initWithType:type];
    
    [self.navigationController pushViewController:lockVc animated:YES];
}

@end
