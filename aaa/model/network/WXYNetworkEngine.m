//
//  WXYNetworoEngine.m
//  yimo_ios
//
//  Created by wxy325 on 12/26/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import "WXYNetworkEngine.h"
#import "WXYNetworkOperation.h"
#import "WXYSettingManager.h"
//#import "GraphicName.h"
#import "NSDictionary+noNilValueForKey.h"

//#define HOST_NAME @"10.60.42.200:12357/YimoERP"
#define HOST_NAME @"192.168.1.100/hanjie"
#define URL_USER_LOGIN @"user_login.php"
#define URL_USER_REGISTER @"user_register.php"
#define URL_USER_INFO_UPDATE @"user_info_update.php"
#define URL_USER_COVER_UPDATE @"user_cover_update.php"


@interface WXYNetworkEngine ()
//Private Method
- (MKNetworkOperation*)startOperationWithPath:(NSString*)path
                                    needLogin:(BOOL)fLogin
                                     paramers:(NSDictionary*)paramDict
                                     dataDict:(NSDictionary*)dataDict
                                  onSucceeded:(OperationSucceedBlock)succeedBlock
                                      onError:(OperationErrorBlock)errorBlock;
- (MKNetworkOperation*)startOperationWithPath:(NSString*)path
                                    needLogin:(BOOL)fLogin
                                     paramers:(NSDictionary*)paramDict
                                  onSucceeded:(OperationSucceedBlock)succeedBlock
                                      onError:(OperationErrorBlock)errorBlock;

@end

@implementation WXYNetworkEngine
#pragma mark - Static Method
+ (WXYNetworkEngine*)shareNetworkEngine
{
    static WXYNetworkEngine* s_networkEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_networkEngine = [[WXYNetworkEngine alloc] initWithHostName:HOST_NAME];
    });
    return s_networkEngine;
}
#pragma mark - Init Method
- (id)initWithHostName:(NSString *)hostName
{
    self = [super initWithHostName:hostName];
    if (self)
    {
        [self registerOperationSubclass:[WXYNetworkOperation class]];
        [self useCache];
    }
    return self;
}
#pragma mark - Private Method
- (MKNetworkOperation*)startOperationWithPath:(NSString*)path
                                    needLogin:(BOOL)fLogin
                                     paramers:(NSDictionary*)paramDict
                                     dataDict:(NSDictionary*)dataDict
                                  onSucceeded:(OperationSucceedBlock)succeedBlock
                                      onError:(OperationErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    if (fLogin)
    {
        [params setObject:SHARE_SETTING_MANAGER.currentUserInfo.userName forKey:@"user_name"];
        [params setObject:SHARE_SETTING_MANAGER.currentUserInfo.password forKey:@"password"];
    }
//    if (userInfo)
//    {
//        [params setValue:userInfo.accessToken forKey:@"access_token"];
//    }
    [params addEntriesFromDictionary:paramDict];
    op = [self operationWithPath:path
                          params:params
                      httpMethod:@"POST"
                             ssl:NO];
    for (NSString* key in dataDict.allKeys)
    {
        [op addData:dataDict[key] forKey:key];
    }
    
    [op addCompletionHandler:succeedBlock errorHandler:errorBlock];
    [self enqueueOperation:op forceReload:YES];
    return op;
}
- (MKNetworkOperation*)startOperationWithPath:(NSString*)path
                                    needLogin:(BOOL)fLogin
                                     paramers:(NSDictionary*)paramDict
                                  onSucceeded:(OperationSucceedBlock)succeedBlock
                                      onError:(OperationErrorBlock)errorBlock
{
    return [self startOperationWithPath:path needLogin:fLogin paramers:paramDict dataDict:nil onSucceeded:succeedBlock onError:errorBlock];
}


#pragma mark - Client
- (MKNetworkOperation*)userLoginWithName:(NSString*)name password:(NSString*)passwd onSucceed:(VoidBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    op = [self startOperationWithPath:URL_USER_LOGIN needLogin:NO paramers:@{@"user_name":name, @"password":passwd}onSucceeded:^(MKNetworkOperation *completedOperation) {
        if (succeedBlock)
        {
            succeedBlock();
        }
    } onError:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (errorBlock)
        {
            errorBlock(error);
        }
    }];
    return op;
}

- (MKNetworkOperation*)userRegisterWithname:(NSString*)userName familyId:(NSNumber*)familyId password:(NSString*)password onSucceed:(VoidBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:URL_USER_REGISTER needLogin:NO paramers:@{@"user_name":userName, @"family_id":familyId, @"family_password":password} onSucceeded:^(MKNetworkOperation *completedOperation) {
        if (succeedBlock)
        {
            succeedBlock();
        }
    } onError:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (errorBlock)
        {
            errorBlock(error);
        }
    }];
    
    return op;
}

- (MKNetworkOperation*)userInfoUpdateProvince:(NSString*)province city:(NSString*)city screenName:(NSString*)screenName onSucceed:(VoidBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:URL_USER_INFO_UPDATE needLogin:YES paramers:@{@"province":province, @"city":city, @"screen_name":screenName} onSucceeded:^(MKNetworkOperation *completedOperation) {
        if (succeedBlock)
        {
            succeedBlock();
        }
    } onError:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (errorBlock)
        {
            errorBlock(error);
        }
    }];
    
    return op;
}

- (MKNetworkOperation*)userCoverUpdate:(UIImage*)newCover onSucceed:(VoidBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    NSData *imageData = UIImageJPEGRepresentation(newCover, 0.5);
    NSDictionary* imageDict = @{@"image":imageData};
    op = [self startOperationWithPath:URL_USER_COVER_UPDATE needLogin:YES paramers:@{@"type":@"jpg"} dataDict:imageDict onSucceeded:^(MKNetworkOperation *completedOperation) {
        if (succeedBlock)
        {
            succeedBlock();
        }
    } onError:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (errorBlock)
        {
            errorBlock(error);
        }
    }];
    
    return op;
}
@end
