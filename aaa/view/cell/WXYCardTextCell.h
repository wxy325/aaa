//
//  WXYCardTextCell.h
//  aaa
//
//  Created by wxy325 on 12/31/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CardEntity;

@protocol WXYCardTextCellDelegate <NSObject>

- (void)commentButtonPressed:(UITableViewCell*)cell;

@end

@interface WXYCardTextCell : UITableViewCell

@property (weak, nonatomic) NSObject<WXYCardTextCellDelegate>* delegate;

@property (weak, nonatomic) IBOutlet UIImageView *timeline;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UIImageView* userHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel* userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel* dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView* picView;
@property (weak, nonatomic) IBOutlet UILabel* contentLabel;
//@property (weak, nonatomic) IBOutlet UIView* commentView;

+ (WXYCardTextCell*)makeView;

- (void)bind:(CardEntity*)entity;
+ (float)getHeight:(CardEntity*)entity;

- (IBAction)commendButtonPressed:(id)sender;
@end
