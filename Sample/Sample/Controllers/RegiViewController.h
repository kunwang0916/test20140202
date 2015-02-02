//
//  RegiViewController.h
//  Sample
//
//  Created by wangkun on 15/2/1.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataViewController.h"

@interface RegiViewController : DataViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *passwordLabel;
@property (strong, nonatomic) IBOutlet UILabel *universityLabel;
@property (strong, nonatomic) IBOutlet UILabel *birthdayLabel;

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *universityField;
@property (strong, nonatomic) IBOutlet UITextField *birthdayField;

@property (strong, nonatomic) IBOutlet UIButton *doneButton;
@property (strong, nonatomic) IBOutlet UIButton *exportButton;

- (IBAction)doneButtonClicked:(id)sender;
- (IBAction)exportButtonClicked:(id)sender;

@end
