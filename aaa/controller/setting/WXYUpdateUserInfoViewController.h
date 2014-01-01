//
//  WXYUpdateUserInfoViewController.h
//  aaa
//
//  Created by wxy325 on 1/2/14.
//  Copyright (c) 2014 Tongji Univ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXYUpdateUserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *screenNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *provinceTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
- (IBAction)submitButtonPressed:(id)sender;

@end
