//
//  WXYPostViewController.m
//  aaa
//
//  Created by wxy325 on 1/2/14.
//  Copyright (c) 2014 Tongji Univ. All rights reserved.
//

#import "WXYPostViewController.h"
#import "UIViewController+ShowHud.h"


@interface WXYPostViewController ()

@end

@implementation WXYPostViewController

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

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismiss];
}

- (IBAction)submitButtonPressed:(id)sender {
    [self.contentTextView resignFirstResponder];
    if (!self.contentTextView.text.length && !self.option)
    {
        [self showErrorHudWithText:@"请填写内容"];
        return;
    }
    if (self.postBlock)
    {
        MBProgressHUD* hud = [self showNetworkWaitingHud];
        self.postBlock(self.contentTextView.text, ^
        {
            [hud hide:YES];
            [self showSuccessHudWithText:@"成功"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:HUD_DELAY_DEFAULT];
        },^(NSError* error){
            [hud hide:YES];
            [self showErrorHudWithText:@"系统错误，请稍后再试"];
        });
    }
    
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
