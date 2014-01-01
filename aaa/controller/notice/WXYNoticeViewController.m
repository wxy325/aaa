//
//  WXYNoticeViewController.m
//  aaa
//
//  Created by wxy325 on 12/31/13.
//  Copyright (c) 2013 Tongji Univ. All rights reserved.
//

#import "WXYNoticeViewController.h"
#import "WXYNetworkEngine.h"
#import "UIViewController+ShowHud.h"
#import "Notice.h"

@interface WXYNoticeViewController ()

@property (strong, nonatomic) NSArray* datasourceArray;

@end

@implementation WXYNoticeViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    MBProgressHUD* hud = [self showNetworkWaitingHud];
    [SHARE_NW_ENGINE messageSystemListOnSucceed:^(NSArray *resultArray) {
        self.datasourceArray = resultArray;
        [hud hide:YES];
        [self.tableView reloadData];
    } onError:^(NSError *error) {
        [hud hide:YES];
        [self showErrorHudWithText:@"系统错误，请稍后再试"];
    }];
}

#pragma mark - UITableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* IDentifier = @"Identifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:IDentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDentifier];
    }
    
    Notice* n = self.datasourceArray[indexPath.row];
    cell.textLabel.text = n.title;
    cell.detailTextLabel.text = n.content;
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasourceArray.count;
}
#pragma mark - UITableView Delegate

@end
