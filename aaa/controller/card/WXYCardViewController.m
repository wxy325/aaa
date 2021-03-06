//
//  WXYCardViewController.m
//  aaa
//
//  Created by wxy325 on 1/1/14.
//  Copyright (c) 2014 Tongji Univ. All rights reserved.
//

#import "WXYCardViewController.h"
#import "WXYCardTextCell.h"
#import "UIViewController+ShowHud.h"
#import "WXYNetworkEngine.h"
#import "WXYHomeCoverView.h"
#import "WXYSettingManager.h"
#import "WXYPostViewController.h"

#define BGCOLOR [UIColor colorWithRed:235.f/255.f green:235.f/255.f blue:235.f/255.f alpha:1.f]

@interface WXYCardViewController ()

@property (strong, nonatomic) NSArray* datasourceArray;
@property (strong, nonatomic) WXYHomeCoverView* coverView;

@end

@implementation WXYCardViewController
@synthesize coverView = _coverView;
- (WXYHomeCoverView*)coverView
{
    if (!_coverView)
    {
        _coverView = [WXYHomeCoverView makeView];
    }
    return _coverView;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = BGCOLOR;
    self.view.backgroundColor = BGCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.coverView;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.coverView bind:SHARE_SETTING_MANAGER.currentUserInfo];
    [SHARE_NW_ENGINE userGetInfoOnSucceed:^{
        [self.coverView bind:SHARE_SETTING_MANAGER.currentUserInfo];
    } onError:^(NSError *error) {
        
    }];
    
    MBProgressHUD* hud = [self showNetworkWaitingHud];
    [SHARE_NW_ENGINE cardGetListPage:@0 OnSucceed:^(NSArray *resultArray) {
        self.datasourceArray = resultArray;
        [hud hide:YES];
        [self.tableView reloadData];
    } onError:^(NSError *error) {
        [hud hide:YES];
        [self showErrorHudWithText:@"系统错误"];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.datasourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    WXYCardTextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [WXYCardTextCell makeView];
    }
    [cell bind:(CardEntity*)self.datasourceArray[indexPath.row]];
    cell.delegate = self;
    cell.first = indexPath.row == 0;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WXYCardTextCell getHeight:(CardEntity*)self.datasourceArray[indexPath.row]];
}

- (void)addComment:(UITableViewCell *)cell
{
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    __block CardEntity* card = self.datasourceArray[indexPath.row];
    
    WXYPostViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WXYPostViewController"];
    vc.option = NO;
    vc.postBlock = ^(NSString* content, VoidBlock succeedBlock, ErrorBlock errorBlock)
    {
        [SHARE_NW_ENGINE cardAddCommentCardId:card.cardId content:content onSucceed:succeedBlock onError:errorBlock];
    };
    [self presentViewController:vc animated:YES completion:nil];
}
@end
