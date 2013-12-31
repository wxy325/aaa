//
//  ActivityShopEntity.m
//  yimo_ios
//
//  Created by wxy325 on 12/28/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import "ActivityShopEntity.h"

@implementation ActivityShopEntity
- (ActivityShopToChooseType)getToChooseType
{
    if (!self.activity)
    {
        return ActivityShopToChooseTypeActivity;
    }
    else if (!self.shopInfo)
    {
        return ActivityShopToChooseTypeShop;
    }
    else
    {
        return ActivityShopToChooseTypeNone;
    }
}

- (NSString*)getToChooseTitle
{
    switch ([self getToChooseType])
    {
        case ActivityShopToChooseTypeShop:
            return @"请选择商店";
        case ActivityShopToChooseTypeActivity:
            return @"请选择活动";
        default:
            return @"";
    }
}
@end
