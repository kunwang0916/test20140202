//
//  WelcomeViewController.h
//  Sample
//
//  Created by wangkun on 15/2/1.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataViewController.h"

@interface WelcomeViewController : DataViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIButton *takePhotoBtn;
@property (strong, nonatomic) IBOutlet UIButton *regButton;
@property (strong, nonatomic) IBOutlet UITextField *userNameField;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;

- (IBAction)takePhotoButtonClicked:(id)sender;
- (IBAction)registerButtonClicked:(id)sender;


@end
