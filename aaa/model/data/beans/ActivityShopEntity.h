//
//  ActivityShopEntity.h
//  yimo_ios
//
//  Created by wxy325 on 12/28/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ActivityInfo;
@class ShopInfo;

typedef NS_ENUM(NSUInteger, ActivityShopToChooseType)
{
    ActivityShopToChooseTypeActivity,
    ActivityShopToChooseTypeShop,
    ActivityShopToChooseTypeNone
};

@interface ActivityShopEntity : NSObject

@property (strong, nonatomic) ActivityInfo* activity;
@property (strong, nonatomic) ShopInfo* shopInfo;

- (ActivityShopToChooseType)getToChooseType;
- (NSString*)getToChooseTitle;
@end
