//
//  UserInfo.m
//  yimo_ios
//
//  Created by wxy325 on 12/26/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import "UserInfo.h"
#import "NSDictionary+noNilValueForKey.h"

@implementation UserInfo
@dynamic location;
- (NSString*)location
{
    return [NSString stringWithFormat:@"%@ %@",self.province,self.city];
}

//#pragma mark -
//#pragma mark NSCoding
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    [encoder encodeObject:self.userName forKey:@"userName"];
//    [encoder encodeObject:self.password forKey:@"password"];
//    [encoder encodeObject:self.headPhotoUrl forKey:@"headPhotoUrl"];
//    [encoder encodeObject:self.coverUrl forKey:@"coverUrl"];
//    
//
//}
//- (id)initWithCoder:(NSCoder *)decoder
//{
//    self = [super init];
//    if (self)
//    {
//        //必须与上面的encode顺序相同
//        self.userName = [decoder decodeObjectForKey:@"userName"];
//        self.password = [decoder decodeObjectForKey:@"password"];
//        self.headPhotoUrl = [decoder decodeObjectForKey:@"headPhotoUrl"];
//        self.coverUrl = [decoder decodeObjectForKey:@"coverUrl"];
//    }
//    return self;
//}
//#pragma mark -
//#pragma mark NSCopy
//- (id)copyWithZone:(NSZone *)zone
//{
//    UserInfo* copy = [[[self class] allocWithZone:zone] init];
//    copy.userName = [self.userName copyWithZone:zone];
//    copy.password = [self.password copyWithZone:zone];
//    copy.headPhotoUrl = [self.headPhotoUrl copyWithZone:zone];
//    copy.coverUrl = [self.coverUrl copyWithZone:zone];
//    
//    return copy;
//}

#pragma mark - Dict
- (NSDictionary*)toDict
{

    
    NSMutableDictionary* dict = [@{} mutableCopy];
    [dict setNoNilValue:self.userName forKey:@"userName"];
    [dict setNoNilValue:self.password forKey:@"password"];
    [dict setNoNilValue:self.headPhotoUrl forKey:@"headPhotoUrl"];
    [dict setNoNilValue:self.coverUrl forKey:@"coverUrl"];
    [dict setNoNilValue:self.province forKey:@"province"];
    [dict setNoNilValue:self.city forKey:@"city"];
    [dict setNoNilValue:self.screenName forKey:@"screenName"];
    //@{@"userName":self.userName, @"password":self.password, @"headPhotoUrl":self.headPhotoUrl, @"coverUrl":self.coverUrl, @"location":self.location};
    return dict;
}
- (id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        self.userName = dict[@"userName"];
        self.password = dict[@"password"];
        self.headPhotoUrl = dict[@"headPhotoUrl"];
        self.coverUrl = dict[@"coverUrl"];
        self.province = dict[@"province"];
        self.city = dict[@"city"];
        self.screenName = dict[@"screenName"];
    }
    return self;
}
@end
