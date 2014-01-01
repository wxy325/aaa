//
//  WXYNewViewController.m
//  aaa
//
//  Created by wxy325 on 1/2/14.
//  Copyright (c) 2014 Tongji Univ. All rights reserved.
//

#import "WXYNewViewController.h"
#import "WXYNetworkEngine.h"
#import "WXYPostViewController.h"
#define kActionSheetShoot 0
#define kActionSheetSelect 1

@interface WXYNewViewController ()

@property (strong, nonatomic) UIImagePickerController* imagePicker;

@end

@implementation WXYNewViewController
- (UIImagePickerController*)imagePicker
{
    if (!_imagePicker)
    {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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

- (IBAction)newTextButtonPressed:(id)sender
{
    WXYPostViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WXYPostViewController"];
    vc.option = NO;
    vc.postBlock = ^(NSString* content, VoidBlock succeedBlock, ErrorBlock errorBlock)
    {
        [SHARE_NW_ENGINE cardUploadWithContent:content image:nil imageType:nil onSucceed:succeedBlock onError:errorBlock];
//        [SHARE_NW_ENGINE cardAddCommentCardId:card.cardId content:content onSucceed:succeedBlock onError:errorBlock];
    };
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (IBAction)newImageButtonPressed:(id)sender
{
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍新照片" otherButtonTitles:@"从相册选择", nil];
    
    [sheet showInView:self.view.superview];
    
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
    [picker dismissViewControllerAnimated:NO completion:nil];
//    [self performSelector:@selector(showAddImage:) withObject:chosenImage afterDelay:1.f];
    [self showAddImage:chosenImage];
    

}

- (void)showAddImage:(UIImage*)chosenImage
{
    WXYPostViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WXYPostViewController"];
    vc.option = NO;
    vc.postBlock = ^(NSString* content, VoidBlock succeedBlock, ErrorBlock errorBlock)
    {
        [SHARE_NW_ENGINE cardUploadWithContent:content image:chosenImage imageType:@"jpg" onSucceed:succeedBlock onError:errorBlock];
        //        [SHARE_NW_ENGINE cardAddCommentCardId:card.cardId content:content onSucceed:succeedBlock onError:errorBlock];
    };
    [self presentViewController:vc animated:YES completion:nil];

}
@end
