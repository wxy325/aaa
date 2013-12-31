//
//  WXYHomeCoverView.m
//  aaa
//
//  Created by wxy325 on 12/31/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import "WXYHomeCoverView.h"
#import "UserInfo.h"
#import "UIImageView+MKNetworkKitAdditions.h"


@implementation WXYHomeCoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)bind:(UserInfo*)userInfo
{
    self.userNameLabel.text = userInfo.userName;
    [self.headPhotoImageView setImageFromURL:[NSURL URLWithString:userInfo.headPhotoUrl] placeHolderImage:nil animation:YES];
    [self.coverImageView setImageFromURL:[NSURL URLWithString:userInfo.coverUrl] placeHolderImage:nil animation:YES];
}

+ (WXYHomeCoverView*)makeView
{
    UINib* nib = [UINib nibWithNibName:@"WXYHomeCoverView" bundle:[NSBundle mainBundle]];
    NSArray* array = [nib instantiateWithOwner:self options:nil];
    if (array.count)
    {
        return array[0];
    }
    else
    {
        return nil;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
