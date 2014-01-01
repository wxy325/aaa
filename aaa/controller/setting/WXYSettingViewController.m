//
//  WXYSettingViewController.m
//  aaa
//
//  Created by wxy325 on 1/2/14.
//  Copyright (c) 2014 Tongji Univ. All rights reserved.
//

#import "WXYSettingViewController.h"
#import "WXYNetworkEngine.h"
#import "UIViewController+ShowHud.h"
#import "WXYSettingManager.h"
#define kActionSheetShoot 0
#define kActionSheetSelect 1
@interface WXYSettingViewController ()

@property (strong, nonatomic) UIImagePickerController* imagePicker;
@property (assign, nonatomic) int sRow;

@end

@implementation WXYSettingViewController
- (UIImagePickerController*)imagePicker
{
    if (!_imagePicker)
    {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;f
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0)
    {
        self.sRow = indexPath.row;
        UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍新照片" otherButtonTitles:@"从相册选择", nil];
        
        [sheet showInView:self.view.superview];
    }
}



#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == kActionSheetShoot)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            //            UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagePicker animated:YES completion:^{}];
            
            
        }
    }
    else if (buttonIndex == kActionSheetSelect)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.imagePicker animated:YES completion:^{}];
        }
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    /*
     UIImage *shrunkenImage = [self shrinkImage:chosenImage
     toSize:self.imageView.bounds.size];
     self.image = shrunkenImage;
     */
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    if (!chosenImage)
    {
        chosenImage = info[UIImagePickerControllerOriginalImage];
    }
    
    
    //    UIImage* image = [self imageWithImage:chosenImage scaledToSize:CGSizeMake(chosenImage.size.width / 2, chosenImage.size.height / 2)];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    MBProgressHUD* hud = [self showNetworkWaitingHud];
    VoidBlock succeedBlock = ^{
        [hud hide:YES];
        [self showSuccessHudWithText:@"成功"];
    };
    ErrorBlock errorBlock = ^(NSError *error) {
        [hud hide:YES];
        [self showErrorHudWithText:@"系统错误，请稍后再试"];
    };
    if (self.sRow == 0)
    {
        [SHARE_NW_ENGINE userHeadUpdate:chosenImage onSucceed:succeedBlock onError:errorBlock];
    }
    else
    {
        [SHARE_NW_ENGINE userCoverUpdate:chosenImage onSucceed:succeedBlock onError:errorBlock];
    }
    //    [self performSelector:@selector(showAddImage:) withObject:chosenImage afterDelay:1.f];
//    [self showAddImage:chosenImage];
    
    
}
@end
