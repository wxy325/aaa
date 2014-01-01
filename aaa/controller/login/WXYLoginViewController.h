//
//  WXYLoginViewController.h
//  aaa
//
//  Created by wxy325 on 1/1/14.
//  Copyright (c) 2014 Tongji Univ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXYLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
- (IBAction)loginButtonPressed:(id)sender;

@end
