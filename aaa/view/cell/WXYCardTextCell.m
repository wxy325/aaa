//
//  WXYCardTextCell.m
//  aaa
//
//  Created by wxy325 on 12/31/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import "WXYCardTextCell.h"
#import "WXYDataModel.h"
#import "UIImageView+MKNetworkKitAdditions.h"
#import "WXYNetworkEngine.h"


@implementation WXYCardTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bind:(CardEntity*)entity
{
    self.userNameLabel.text = entity.user.screenName;
    self.userHeadImageView.image = nil;
    self.dateLabel.text = entity.createAt;
    [self.userHeadImageView setImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@",HOST_NAME,entity.user.headPhotoUrl]] placeHolderImage:nil animation:YES completion:^(UIImageView *imageView, UIImage *image) {
                    imageView.contentMode = UIViewContentModeScaleToFill;
    }];
    float textBase = 227.f;
    if (entity.imageUrl)
    {
        self.picView.hidden = NO;
        self.picView.image = nil;
        [self.picView setImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@",HOST_NAME,entity.imageUrl]] placeHolderImage:nil animation:YES completion:^(UIImageView *imageView, UIImage *image) {
            [self layoutSubviews];
//            imageView.contentMode = UIViewContentModeScaleToFill;
        }];

    }
    else
    {
        textBase = 69.f;
        self.imageView.hidden = YES;
    }
    CGSize size = [entity.content sizeWithFont:[UIFont systemFontOfSize:12.f] constrainedToSize:CGSizeMake(270, INFINITY)];
    CGRect preFrame = self.contentLabel.frame;
    self.contentLabel.frame = CGRectMake(preFrame.origin.x, textBase, preFrame.size.width, size.height + 10);
    textBase += size.height;
    self.contentLabel.text = entity.content;
    
    UIImage* bgImage = [[UIImage imageNamed:@"card_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.f, 0.f, 10.f, 0.f) resizingMode:UIImageResizingModeStretch ];
    
    float height = [WXYCardTextCell getHeight:entity];
    self.bgImageView.frame = CGRectMake(8, 5, 305, height - 20);
    self.bgImageView.image = bgImage;
    CGRect tlFrame = self.timeline.frame;
    self.timeline.frame = CGRectMake(tlFrame.origin.x, tlFrame.origin.y, tlFrame.size.width, height);
}

+ (float)getHeight:(CardEntity*)entity
{
    float textBase = 227.f;
    if (!entity.imageUrl)
    {
        textBase = 69.f;
    }
    CGSize size = [entity.content sizeWithFont:[UIFont systemFontOfSize:12.f] constrainedToSize:CGSizeMake(270, INFINITY)];

    textBase += size.height + 10;
    textBase += 30.f;
    return textBase;
}
+ (WXYCardTextCell*)makeView
{
    UINib* nib = [UINib nibWithNibName:@"WXYCardTextCell" bundle:[NSBundle mainBundle]];
    NSArray* array = [nib instantiateWithOwner:self options:nil];
    if (array.count)
    {
        WXYCardTextCell* cell = array[0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView* bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorWithRed:235.f/255.f green:235.f/255.f blue:235.f/255.f alpha:1.f];
        cell.backgroundView = bgView;
        return cell;
        
    }
    else
    {
        return nil;
    }
}
@end
