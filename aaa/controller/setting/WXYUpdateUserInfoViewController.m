//
//  WXYUpdateUserInfoViewController.m
//  aaa
//
//  Created by wxy325 on 1/2/14.
//  Copyright (c) 2014 Tongji Univ. All rights reserved.
//

#import "WXYUpdateUserInfoViewController.h"
#import "WXYNetworkEngine.h"
#import "UIViewController+ShowHud.h"
#import "WXYSettingManager.h"

@interface WXYUpdateUserInfoViewController ()

@end

@implementation WXYUpdateUserInfoViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UserInfo* info = SHARE_SETTING_MANAGER.currentUserInfo;
    self.screenNameTextField.text = info.screenName;
    self.provinceTextField.text = info.province;
    self.cityTextField.text = info.city;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitButtonPressed:(id)sender
{
    [self.screenNameTextField resignFirstResponder];
    [self.cityTextField resignFirstResponder];
    [self.provinceTextField resignFirstResponder];
    NSString* screenName = self.screenNameTextField.text;
    NSString* city = self.cityTextField.text;
    NSString* province = self.provinceTextField.text;
    if (!screenName.length || !city.length || !province.length)
    {
        [self showErrorHudWithText:@"请填写完整信息"];
        return;
    }
    
    MBProgressHUD* hud = [self showNetworkWaitingHud];
    
    [SHARE_NW_ENGINE userInfoUpdateProvince:province city:city screenName:screenName onSucceed:^{
        [hud hide:YES];
        [self showSuccessHudWithText:@"更新成功"];
    } onError:^(NSError *error) {
        [hud hide:YES];
        [self showErrorHudWithText:@"系统错误，请稍后再试"];
    }];
}
@end
