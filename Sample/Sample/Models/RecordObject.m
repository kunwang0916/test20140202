//
//  RecordObject.m
//  Sample
//
//  Created by wangkun on 15/2/1.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

#import "RecordObject.h"

@implementation RecordObject

- (void)dummyData
{
    self.user_id = @"1";
    self.user_name = @"user";
    self.character_id = @"1";
    self.character_type = @"1";
    
    self.time_lp_on_character = @"0",
    self.time_lp_press = @"0",
    self.pressue_applied = @"0",
    self.position_x = @"0",
    self.postion_y = @"0",
    self.t_delay_press_character = @"0";
}

+ (int)intValumeFromCharacter:(unichar)character
{
    character = character - 'A' + 1;
    NSNumber *number = [NSNumber numberWithUnsignedChar:character] ;
    return [number intValue];
}

+ (int)characterType:(unichar)character
{
    if ([[NSMutableCharacterSet letterCharacterSet] characterIsMember:character])
    {
        //alphabet
        return 1;
    }
    else if ([[NSMutableCharacterSet decimalDigitCharacterSet] characterIsMember:character])
    {
        //number
        return 2;
    }
    else
    {
        //specail
        return 3;
    }
}

- (void)functionTest
{
    NSString *string = @"123EEFDaa%^#eqwe!#!@$#$^%^*&(XZXZCDwaqw[]}";
    
    for (int i = 0; i < [string length]; i++)
    {
        unichar character = [string characterAtIndex:i];
        NSLog(@"charac: %c : type: %d, id: %d",character, [RecordObject characterType:character], [RecordObject intValumeFromCharacter:character]);
    }
}
@end
