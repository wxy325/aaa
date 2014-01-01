//
//  WXYLoginViewController.m
//  aaa
//
//  Created by wxy325 on 1/1/14.
//  Copyright (c) 2014 Tongji Univ. All rights reserved.
//

#import "WXYLoginViewController.h"
#import "WXYNetworkEngine.h"
#import "UIViewController+ShowHud.h"
#import "WXYSettingManager.h"

@interface WXYLoginViewController ()

@end

@implementation WXYLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender
{
    [self.mailTextField resignFirstResponder];
    [self.passwdTextField resignFirstResponder];
    
    
    NSString* name = self.mailTextField.text;
    NSString* passwd = self.passwdTextField.text;
    if (!name.length || !passwd.length)
    {
        [self showErrorHudWithText:@"请填写完整信息"];
        return;
    }
    
    MBProgressHUD* hud =  [self showNetworkWaitingHud];

    [SHARE_NW_ENGINE userLoginWithName:name password:passwd onSucceed:^{
        [hud hide:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } onError:^(NSError *error) {
        [hud hide:YES];
        [self showErrorHudWithText:@"密码错误"];
    }];
    
    
}
@end
