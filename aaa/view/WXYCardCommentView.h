//
//  WXYCardCommentView.h
//  aaa
//
//  Created by wxy325 on 12/31/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXYCardCommentView : UIView
@property (weak, nonatomic) IBOutlet UIImageView* userHeadPhotoImageView;
//@property (weak, nonatomic) IBOutlet UILabel* userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel* contentLabel;
@property (weak, nonatomic) IBOutlet UILabel* dateLabel;



+ (WXYCardCommentView*)makeView;
@end
