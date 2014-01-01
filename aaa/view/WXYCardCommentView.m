//
//  WXYCardCommentView.m
//  aaa
//
//  Created by wxy325 on 12/31/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import "WXYCardCommentView.h"
#import "CommentEntity.h"
#import "WXYNetworkEngine.h"
#import "UIImageView+MKNetworkKitAdditions.h"
@implementation WXYCardCommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (WXYCardCommentView*)makeView
{
    UINib* nib = [UINib nibWithNibName:@"WXYCardCommentView" bundle:[NSBundle mainBundle]];
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

- (void)bind:(CommentEntity*)comment
{
    self.dateLabel.text = comment.createAt;
    self.contentLabel.text = [NSString stringWithFormat:@"%@:%@",comment.user.screenName, comment.content];
    self.userHeadPhotoImageView.image = nil;
    [self.userHeadPhotoImageView setImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@",HOST_NAME,comment.user.headPhotoUrl]] placeHolderImage:nil animation:YES];
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
