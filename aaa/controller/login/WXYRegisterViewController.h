//
//  WXYRegisterViewController.h
//  aaa
//
//  Created by wxy325 on 1/1/14.
//  Copyright (c) 2014 Tongji Univ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXYRegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *familyIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
- (IBAction)submitButtonPressed:(id)sender;

@end
