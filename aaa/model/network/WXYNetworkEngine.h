//
//  WXYNetworoEngine.h
//  yimo_ios
//
//  Created by wxy325 on 12/26/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "WXYBlock.h"
#import "WXYDataModel.h"

#define SHARE_NW_ENGINE [WXYNetworkEngine shareNetworkEngine]

@interface WXYNetworkEngine : MKNetworkEngine

+ (WXYNetworkEngine*)shareNetworkEngine;


//Client
//login
- (MKNetworkOperation*)userLoginWithName:(NSString*)name password:(NSString*)passwd onSucceed:(VoidBlock)succeedBlock onError:(ErrorBlock)errorBlock;
//register
- (MKNetworkOperation*)userRegisterWithname:(NSString*)userName familyId:(NSNumber*)familyId password:(NSString*)password onSucceed:(VoidBlock)succeedBlock onError:(ErrorBlock)errorBlock;
//user info update
- (MKNetworkOperation*)userInfoUpdateProvince:(NSString*)province city:(NSString*)city screenName:(NSString*)screenName onSucceed:(VoidBlock)succeedBlock onError:(ErrorBlock)errorBlock;
//user cover update
- (MKNetworkOperation*)userCoverUpdate:(UIImage*)newCover onSucceed:(VoidBlock)succeedBlock onError:(ErrorBlock)errorBlock;



@end
