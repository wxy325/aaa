//
//  WXYNewViewController.h
//  aaa
//
//  Created by wxy325 on 1/2/14.
//  Copyright (c) 2014 Tongji Univ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXYNewViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>
- (IBAction)newTextButtonPressed:(id)sender;
- (IBAction)newImageButtonPressed:(id)sender;

@end
