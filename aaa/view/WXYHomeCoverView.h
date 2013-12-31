//
//  WXYHomeCoverView.h
//  aaa
//
//  Created by wxy325 on 12/31/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserInfo;
@interface WXYHomeCoverView : UIView

@property (weak, nonatomic) IBOutlet UIImageView* coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView* headPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel* userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel* locationLabel;

- (void)bind:(UserInfo*)userInfo;

+ (WXYHomeCoverView*)makeView;

@end
