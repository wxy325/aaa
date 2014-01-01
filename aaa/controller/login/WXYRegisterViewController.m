//
//  WXYRegisterViewController.m
//  aaa
//
//  Created by wxy325 on 1/1/14.
//  Copyright (c) 2014 Tongji Univ. All rights reserved.
//

#import "WXYRegisterViewController.h"
#import "WXYNetworkEngine.h"
#import "UIViewController+ShowHud.h"


@interface WXYRegisterViewController ()

@end

@implementation WXYRegisterViewController

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

- (IBAction)submitButtonPressed:(id)sender
{
    [self.mailTextField resignFirstResponder];
    [self.familyIdTextField resignFirstResponder];
    [self.passwdTextField resignFirstResponder];
    
    NSString* name = self.mailTextField.text;
    NSString* familyIdStr = self.familyIdTextField.text;
    NSString* passwd = self.passwdTextField.text;
    if (!name.length || !familyIdStr.length || !passwd.length)
    {
        [self showErrorHudWithText:@"请填写完整信息"];
        return;
    }
    MBProgressHUD* hud = [self showNetworkWaitingHud];
    [SHARE_NW_ENGINE userRegisterWithname:name familyId:@(familyIdStr.longLongValue) password:passwd onSucceed:^{
        [hud hide:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } onError:^(NSError *error) {
        [hud hide:YES];
        [self showErrorHudWithText:@"信息不正确"];
    }];
    
}
@end
