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

#define URL_USER_LOGIN @"user_login.php"
#define URL_USER_REGISTER @"user_register.php"
#define URL_USER_INFO_UPDATE @"user_info_update.php"
#define URL_USER_COVER_UPDATE @"user_cover_update.php"
#define URL_USER_HEAD_UPDATE @"user_head_update.php"
#define URL_USER_GET_INFO @"user_get_info.php"
#define URL_CARD_UPLOAD @"card_upload.php"
#define URL_CARD_LIST @"card_list.php"
#define URL_CARD_ADD_COMMENT @"card_comment_add.php"
#define URL_SYSTEM_MESSAGE_LIST @"message_system_list.php"


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
    if (fLogin && SHARE_SETTING_MANAGER.isLogin)
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
    op = [self startOperationWithPath:URL_USER_LOGIN needLogin:NO paramers:@{@"user_name":name, @"password":passwd}onSucceeded:^(MKNetworkOperation *completedOperation)
    {
        UserInfo* userInfo = [[UserInfo alloc] init];
        userInfo.userName = name;
        userInfo.password = passwd;
        SHARE_SETTING_MANAGER.currentUserInfo = userInfo;
        
        if (succeedBlock)
        {
            succeedBlock();
        }
        
//        [self userGetInfoOnSucceed:^{
//            if (succeedBlock)
//            {
//                
//            }
//        } onError:^(NSError *error) {
//            if (errorBlock)
//            {
//                errorBlock(error);
//            }
//        }];
        
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
        
        UserInfo* userInfo = [[UserInfo alloc] init];
        userInfo.userName = userName;
        userInfo.password = password;
        SHARE_SETTING_MANAGER.currentUserInfo = userInfo;
        
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

- (MKNetworkOperation*)userHeadUpdate:(UIImage*)newHead onSucceed:(VoidBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    NSData *imageData = UIImageJPEGRepresentation(newHead, 0.5);
    NSDictionary* imageDict = @{@"image":imageData};
    op = [self startOperationWithPath:URL_USER_HEAD_UPDATE needLogin:YES paramers:@{@"type":@"jpg"} dataDict:imageDict onSucceeded:^(MKNetworkOperation *completedOperation) {
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

- (MKNetworkOperation*)userGetInfoOnSucceed:(VoidBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:URL_USER_GET_INFO needLogin:YES paramers:@{} onSucceeded:^(MKNetworkOperation *completedOperation) {
        NSDictionary* dict = completedOperation.responseJSON;

        UserInfo* userInfo = SHARE_SETTING_MANAGER.currentUserInfo;
        
        userInfo.location = [NSString stringWithFormat:@"%@ %@",[dict noNilValueForKey:@"province"], [dict noNilValueForKey:@"city"]];
        userInfo.screenName = [dict noNilValueForKey:@"screen_name"];
        userInfo.coverUrl = [dict noNilValueForKey:@"cover_image_url"];
        userInfo.headPhotoUrl = [dict noNilValueForKey:@"head_photo_url"];
        SHARE_SETTING_MANAGER.currentUserInfo = userInfo;
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

- (MKNetworkOperation*)cardUploadWithContent:(NSString*)content image:(UIImage*)image imageType:(NSString*)imageType onSucceed:(VoidBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    NSMutableDictionary* imageDict = [@{} mutableCopy];
    if (image)
    {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        imageDict[@"image"] = imageData;
    }
    if (!content) {
        content = @"";
    }
    
    if (!imageType)
    {
        imageType = @"";
    }
    
    op = [self startOperationWithPath:URL_CARD_UPLOAD needLogin:YES paramers:@{@"content":content, @"type":imageType} dataDict:imageDict onSucceeded:^(MKNetworkOperation *completedOperation) {
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

- (MKNetworkOperation*)cardGetListPage:(NSNumber*)page OnSucceed:(ArrayBlock)succeedBlock onError:(ErrorBlock)errorBlock;
{
    MKNetworkOperation* op = nil;
    op = [self startOperationWithPath:URL_CARD_LIST needLogin:YES paramers:@{@"page":page} onSucceeded:^(MKNetworkOperation *completedOperation) {
        NSArray* responseArray = completedOperation.responseJSON;

        NSMutableArray* returnArray = [@[] mutableCopy];
        for (NSDictionary* dict in responseArray)
        {
            CardEntity* c = [[CardEntity alloc] init];
            NSString* cardIdStr = [dict noNilValueForKey:@"id"];
            c.cardId = @(cardIdStr.longLongValue);
            c.content = [dict noNilValueForKey:@"content"];
            c.imageUrl = [dict noNilValueForKey:@"image_url"];
            c.createAt = [dict noNilValueForKey:@"creat_at"];
            NSDictionary* uDict = [dict noNilValueForKey:@"user"];
            UserEntity* u = [[UserEntity alloc] init];
            u.screenName = [uDict noNilValueForKey:@"screen_name"];
            u.headPhotoUrl = [uDict noNilValueForKey:@"head_photo_url"];
            c.user = u;
            
            NSArray* commentDictArray = [dict noNilValueForKey:@"comment"];
            NSMutableArray* commentArray = [@[] mutableCopy];
            for (NSDictionary* cDict in commentDictArray)
            {
                CommentEntity* com = [[CommentEntity alloc] init];
                com.createAt = [cDict noNilValueForKey:@"creat_at"];
                com.content = [cDict noNilValueForKey:@"content"];
                
                NSDictionary* cuDict = [cDict noNilValueForKey:@"user"];
                UserEntity* cu = [[UserEntity alloc] init];
                cu.screenName = [cuDict noNilValueForKey:@"screen_name"];
                cu.headPhotoUrl = [cuDict noNilValueForKey:@"head_photo_url"];
                com.user = cu;
                [commentArray addObject:com];
            }
            c.commentArray = commentArray;
            [returnArray addObject:c];
        }
        
        if (succeedBlock)
        {
            succeedBlock(returnArray);
        }
    } onError:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (errorBlock)
        {
            errorBlock(error);
        }
    }];
    return op;
}


- (MKNetworkOperation*)cardAddCommentCardId:(NSNumber*)cardId content:(NSString*)content onSucceed:(VoidBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:URL_CARD_ADD_COMMENT
                            needLogin:YES
                             paramers:@{@"card_id":cardId, @"content":content}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              if (succeedBlock)
              {
                  succeedBlock();
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    
    return op;
}

- (MKNetworkOperation*)messageSystemListOnSucceed:(ArrayBlock)succeedBlock onError:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:URL_SYSTEM_MESSAGE_LIST needLogin:YES paramers:@{} onSucceeded:^(MKNetworkOperation *completedOperation) {
        
        NSMutableArray* array = [@[] mutableCopy];
        
        NSArray* responseArray = completedOperation.responseJSON;
        
        
        for (NSDictionary* dict in responseArray)
        {
            Notice* n = [[Notice alloc] init];
            n.title = dict[@"title"];
            n.content = dict[@"content"];
            n.createAt = dict[@"creat_at"];
            [array addObject:n];
        }
        
        if (succeedBlock)
        {
            succeedBlock(array);
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
