//
//  PhotoEntity.h
//  yimo_ios
//
//  Created by wxy325 on 12/28/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PhotoCheckState)
{
    PhotoCheckStateUncheck = 0,
    PhotoCheckStateUnpass = 1 ,
    PhotoCheckStatePass = 2,
    PhotoCheckStateAll = 3
};


@interface PhotoEntity : NSObject

@property (strong, nonatomic) NSNumber* photoId;
@property (assign, nonatomic) PhotoCheckState checkState;
@property (strong, nonatomic) NSString* largeUrl;
@property (strong, nonatomic) NSString* thumbnailUrl;
@property (strong, nonatomic) NSString* time;
@property (strong, nonatomic) NSString* comment;
@property (strong, nonatomic) NSString* rejectReason;
@property (strong, nonatomic) NSString* title;

@end
