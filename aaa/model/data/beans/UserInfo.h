//
//  UserInfo.h
//  yimo_ios
//
//  Created by wxy325 on 12/26/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
//<NSCoding, NSCopying>

@property (strong, nonatomic) NSString* userName;
@property (strong, nonatomic) NSString* password;
@property (strong, nonatomic) NSString* headPhotoUrl;
@property (strong, nonatomic) NSString* coverUrl;
@property (strong, nonatomic) NSString* location;

- (NSDictionary*)toDict;
- (id)initWithDict:(NSDictionary*)dict;

@end
