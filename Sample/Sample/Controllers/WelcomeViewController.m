//
//  WelcomeViewController.m
//  Sample
//
//  Created by wangkun on 15/2/1.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

#import "WelcomeViewController.h"
#import "AppDelegate.h"

@interface WelcomeViewController ()
{    
    UIImage *pickedImage;
    NSString *userName;
}

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataObject = [NSNumber numberWithInt:0];
    // Do any additional setup after loading the view    
}
#pragma mark - IBAction Methods
- (IBAction)takePhotoButtonClicked:(id)sender
{
    [self setEditing:NO];
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

- (IBAction)registerButtonClicked:(id)sender
{
    ((AppDelegate *)([UIApplication sharedApplication].delegate)).userName = [_userNameField text];
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
#pragma mark - UIImagePickerController Delegate
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

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    ((AppDelegate *)([UIApplication sharedApplication].delegate)).userName = [textField text];
}

#pragma mark - Class Methods

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
