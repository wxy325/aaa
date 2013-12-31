//
//  LocationInfo.h
//  yimo_ios
//
//  Created by wxy325 on 12/26/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BrandInfo, ShopInfo;

typedef NS_ENUM(NSUInteger, LocationInfoToChoose)
{
    LocationInfoToChooseBrand,
    LocationInfoToChooseProvince,
    LocationInfoToChooseCity,
    LocationInfoToChooseShop,
    LocationInfoToChooseNone
};

@interface LocationInfo : NSObject

@property (strong, nonatomic) BrandInfo* brand;
@property (strong, nonatomic) NSNumber* provinceCode;
@property (strong, nonatomic) NSNumber* cityCode;
@property (strong, nonatomic) ShopInfo* shop;


@property (nonatomic) NSString* brandName;
@property (nonatomic) NSString* provinceName;
@property (nonatomic) NSString* cityName;
@property (nonatomic) NSString* shopName;

- (LocationInfoToChoose)toChoose;
- (NSDictionary*)toDict;
@end
