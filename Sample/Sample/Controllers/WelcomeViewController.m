//
//  WelcomeViewController.m
//  Sample
//
//  Created by wangkun on 15/2/1.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()
{
    UIButton *takePhotoBtn;
    UIButton *regButton;
    
    UIImage *pickedImage;
    NSString *userName;
}

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataObject = [NSNumber numberWithInt:0];
    // Do any additional setup after loading the view.
    
    //Camera Button
    takePhotoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    takePhotoBtn.frame = CGRectMake(0, 0, 100, 30);
    takePhotoBtn.center = self.view.center;
    [takePhotoBtn setTitle:@"Take a Photo" forState:UIControlStateNormal];
    [takePhotoBtn addTarget:self action:@selector(takePhotoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takePhotoBtn];
    
    regButton = [UIButton buttonWithType:UIButtonTypeSystem];
    regButton.frame = CGRectMake(0, 0, 100, 30);
    regButton.center = self.view.center;
    [regButton setTitle:@"Register" forState:UIControlStateNormal];
    [regButton addTarget:self action:@selector(registerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takePhotoBtn];
    
}

- (void)takePhotoButtonClicked
{
    [UIAlertController showActionSheetInViewController:self
                                             withTitle:@"Choose Pic Source"
                                               message:@""
                                     cancelButtonTitle:@"Cancle"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@[@"Album", @"Camera"]
                    popoverPresentationControllerBlock:^(UIPopoverPresentationController *popover) {
        
    } tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex) {
        if (buttonIndex == 3)
        {
            [self showImagePickerBySourceType:UIImagePickerControllerSourceTypeCamera];
        }
        else if (buttonIndex == 2)
        {
            [self showImagePickerBySourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        }
    }];
}

- (void)showImagePickerBySourceType:(UIImagePickerControllerSourceType) sourceType
{
    if ([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else
    {
        [UIAlertController showAlertInViewController:self
                                           withTitle:@"Source not available!"
                                             message:nil
                                   cancelButtonTitle:@"OK"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:nil
                                            tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex) {
                                  
                                            }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        pickedImage = img;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


- (void)registerButtonClicked
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
