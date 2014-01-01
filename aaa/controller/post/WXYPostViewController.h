//
//  WXYPostViewController.h
//  aaa
//
//  Created by wxy325 on 1/2/14.
//  Copyright (c) 2014 Tongji Univ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXYBlock.h"


@interface WXYPostViewController : UIViewController
- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)submitButtonPressed:(id)sender;
@property (assign, nonatomic) BOOL option;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) PostBlock postBlock;
@end
