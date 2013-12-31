//
//  ActivityInfo.h
//  yimo_ios
//
//  Created by wxy325 on 12/28/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityInfo : NSObject

@property (strong, nonatomic) NSNumber* activityId;
@property (strong, nonatomic) NSString* activityName;
@property (strong, nonatomic) NSNumber* brandId;
@property (strong, nonatomic) NSString* activityDescription;

@end
