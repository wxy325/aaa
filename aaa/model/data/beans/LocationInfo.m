//
//  LocationInfo.m
//  yimo_ios
//
//  Created by wxy325 on 12/26/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import "LocationInfo.h"
#import "BrandInfo.h"
#import "ShopInfo.h"

@implementation LocationInfo

@dynamic brandName;
@dynamic provinceName;
@dynamic cityName;
@dynamic shopName;


+ (NSDictionary*)provinceCityCodeDict
{
    static NSDictionary* dict = nil;
    if (!dict)
    {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"plist"];
        dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
    return dict;
}

- (NSString*)brandName
{
    return self.brand.brandName;
}
- (NSString*)provinceName
{
    NSString* pcStr = self.provinceCode.stringValue;
    if (pcStr)
    {
        NSDictionary* dict = [[LocationInfo provinceCityCodeDict] valueForKey:pcStr];
        NSString* name = dict[@"name"];
        return name;
    }
    return nil;
}
- (NSString*)cityName
{
    return nil;
}
- (NSString*)shopName
{
    return self.shop.shopName;
}

- (LocationInfoToChoose)toChoose
{
    if (!self.brand)
    {
        return LocationInfoToChooseBrand;
    }
    else if (!self.provinceCode)
    {
        return LocationInfoToChooseProvince;
    }
    else if (!self.cityCode)
    {
        return LocationInfoToChooseCity;
    }
    else if (!self.shop)
    {
        return LocationInfoToChooseShop;
    }
    else
    {
        return LocationInfoToChooseNone;
    }
}
- (NSDictionary*)toDict
{
    NSMutableDictionary* dict = [@{} mutableCopy];
    if (self.brand)
    {
        dict[@"brandid"] = self.brand.brandId;
    }
    if (self.provinceCode)
    {
        dict[@"provinceid"] = self.provinceCode;
    }
    if (self.cityCode)
    {
        dict[@"cityid"] = self.cityCode;
    }
    return dict;
}
@end
