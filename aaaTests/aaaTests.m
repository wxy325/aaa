//
//  aaaTests.m
//  aaaTests
//
//  Created by wxy325 on 12/31/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <GHUnitIOS/GHAsyncTestCase.h>
#import "WXYNetworkEngine.h"
#import "WXYSettingManager.h"
@interface aaaTests : XCTestCase

@property (strong, nonatomic) GHAsyncTestCase* asyncTestCase;
@property (strong, nonatomic) WXYNetworkEngine* engine;

@end

@implementation aaaTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.asyncTestCase = [[GHAsyncTestCase alloc] init];
    [self.asyncTestCase setUp];
    self.engine = SHARE_NW_ENGINE;
    [self.asyncTestCase prepare];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUserLogin
{
    [self.engine userLoginWithName:@"jo.jin.lin@gmail.com" password:@"linhan" onSucceed:^{
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } onError:^(NSError *error) {
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

- (void)testIsLogin
{
    UserInfo* userInfo = SHARE_SETTING_MANAGER.currentUserInfo;
    
    XCTAssert(SHARE_SETTING_MANAGER.isLogin, @"未登陆");
}

- (void)testGetUesrInfo
{
    [self.engine userGetInfoOnSucceed:^{
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } onError:^(NSError *error) {
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}
@end
