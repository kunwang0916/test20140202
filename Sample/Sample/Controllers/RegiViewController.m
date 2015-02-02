//
//  RegiViewController.m
//  Sample
//
//  Created by wangkun on 15/2/1.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

#import "RegiViewController.h"
#import "Database.h"

@interface RegiViewController ()
{
}
@end

@implementation RegiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataObject = [NSNumber numberWithInt:1];
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
#pragma mark - Touch Event
- (IBAction)doneButtonClicked:(id)sender
{
    RecordObject *record = [[RecordObject alloc] init];
    [record dummyData];
    [DataBase insertRecord: record];

}

- (IBAction)exportButtonClicked:(id)sender
{
    [DataBase exportAllRecords];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableCharacterSet *characSet;
    
    if ([textField isEqual:_nameField])
    {
        //alphabetic numeric characters
        characSet = [NSMutableCharacterSet alphanumericCharacterSet];
    }
    else if([textField isEqual:_passwordField])
    {
        //can have special characters
        characSet =  [NSMutableCharacterSet alphanumericCharacterSet];
        [characSet formUnionWithCharacterSet: [NSCharacterSet symbolCharacterSet]];
    }
    else if([textField isEqual:_universityField])
    {
        //Alphabetic Characters
        characSet =  [NSMutableCharacterSet letterCharacterSet];
        [characSet formUnionWithCharacterSet:[NSCharacterSet uppercaseLetterCharacterSet]];
    }
    else if([textField isEqual:_birthdayField])
    {
        //Numeric only
        characSet = [NSMutableCharacterSet decimalDigitCharacterSet];
    }
    
    return [self checkIfString:string inCharacterSet:characSet];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:_nameField])
    {
        [_passwordField becomeFirstResponder];
    }
    else if([textField isEqual:_passwordField])
    {
        [_universityField becomeFirstResponder];
    }
    else if([textField isEqual:_universityField])
    {
        [_birthdayField becomeFirstResponder];
    }
    else if([textField isEqual:_birthdayField])
    {

    }
    
    return YES;
}

#pragma mark - NSString Check
- (BOOL)checkIfString:(NSString *)string inCharacterSet:(NSCharacterSet *)rangeSet
{
//    NSCharacterSet *rangeSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:string];
    
    if ([rangeSet isSupersetOfSet: myStringSet])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
