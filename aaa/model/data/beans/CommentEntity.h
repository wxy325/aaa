//
//  CommentEntity.h
//  aaa
//
//  Created by wxy325 on 1/1/14.
//  Copyright (c) 2014 Tongji Univ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserEntity;
@interface CommentEntity : NSObject

@property (strong, nonatomic) UserEntity* user;
@property (strong, nonatomic) NSString* content;
@property (strong, nonatomic) NSString* createAt;

@end
