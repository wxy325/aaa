//
//  WXYCardTextCell.h
//  aaa
//
//  Created by wxy325 on 12/31/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXYCardTextCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView* userHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel* userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel* dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView* imageView;
@property (weak, nonatomic) IBOutlet UILabel* contentLabel;
@property (weak, nonatomic) IBOutlet UIView* commentView;

@end
