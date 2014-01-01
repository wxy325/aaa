//
//  WXYRootViewController.m
//  aaa
//
//  Created by wxy325 on 1/1/14.
//  Copyright (c) 2014 Tongji Univ. All rights reserved.
//

#import "WXYRootViewController.h"
#import "WXYSettingManager.h"
@interface WXYRootViewController ()

@end

@implementation WXYRootViewController

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
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!SHARE_SETTING_MANAGER.isLogin)
    {
        UIViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        [self presentViewController:vc animated:NO completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
