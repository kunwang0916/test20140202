//
//  RegiViewController.m
//  Sample
//
//  Created by wangkun on 15/2/1.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

#import "RegiViewController.h"
#import "Database.h"
#import "AppDefine.h"
#import "AppDelegate.h"

@interface RegiViewController ()
{
    NSTimeInterval lastCharacterInputTimeStamp;
    RecordObject* lastTouchRecord;
}
@end

@implementation RegiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataObject = [NSNumber numberWithInt:1];
    lastCharacterInputTimeStamp = 0;
    lastTouchRecord = [[RecordObject alloc] init];
    [lastTouchRecord dummyData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardTouchEnd:) name:kTouchEndInKeyboardNoti object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTouchEndInKeyboardNoti object:nil];
}

- (void) dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self name:kTouchEndInKeyboardNoti object:nil];
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
    [lastTouchRecord functionTest];
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
    if ([textField isEqual:_nameField])
    {
        ((AppDelegate *)([UIApplication sharedApplication].delegate)).userName = _nameField.text;
        lastTouchRecord.user_name = _nameField.text;
    }
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
        [characSet formUnionWithCharacterSet: [NSCharacterSet controlCharacterSet]];
        [characSet formUnionWithCharacterSet: [NSCharacterSet punctuationCharacterSet]];
        [characSet formUnionWithCharacterSet: [NSCharacterSet nonBaseCharacterSet]];
        [characSet formUnionWithCharacterSet: [NSCharacterSet decomposableCharacterSet]];
    }
    else if([textField isEqual:_universityField])
    {
        //Alphabetic Characters
        characSet =  [NSMutableCharacterSet letterCharacterSet];
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
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:string];
    
    if ([rangeSet isSupersetOfSet: myStringSet])
    {
        [self saveInputString:string];
        NSLog(@"input string:%@", string);
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - Touch In Keyboard End
- (void)keyboardTouchEnd:(NSNotification *) notification
{
    NSNumber *duration = [[notification userInfo] objectForKey:@"duration"];
    NSNumber *press= [[notification userInfo] objectForKey:@"press"];
    NSString *pointString = [[notification userInfo] objectForKey:@"point"];
    CGPoint point = CGPointFromString(pointString);
    
    lastTouchRecord.time_lp_on_character = [NSString stringWithFormat:@"%d", [duration intValue]];
    lastTouchRecord.pressue_applied = [NSString stringWithFormat:@"%d", [press intValue]];
    lastTouchRecord.position_x = [NSString stringWithFormat:@"%d", (int)(point.x)];
    lastTouchRecord.postion_y = [NSString stringWithFormat:@"%d", (int)(point.y)];
}

#pragma mark - Input Records
- (void)saveInputString:(NSString *)inputString
{
    for (int i = 0; i < [inputString length]; i++)
    {
        unichar inputChar = [inputString characterAtIndex:i];
        [self saveInputCharacter:inputChar];
    }
}

- (void)saveInputCharacter:(unichar)inputChar
{
    lastTouchRecord.character_id = [NSString stringWithFormat:@"%d", [RecordObject intValumeFromCharacter:inputChar]];
    lastTouchRecord.character_type = [NSString stringWithFormat:@"%d", [RecordObject characterType:inputChar]];
    
    [DataBase insertRecord:lastTouchRecord];
}

@end
