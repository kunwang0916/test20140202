//
//  RecordObject.h
//  Sample
//
//  Created by wangkun on 15/2/1.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordObject : NSObject

@property (strong, nonatomic) NSString *record_id;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *user_name;
@property (strong, nonatomic) NSString *character_id;
@property (strong, nonatomic) NSString *character_type;

@property (strong, nonatomic) NSString *time_lp_on_character;
@property (strong, nonatomic) NSString *time_lp_press;
@property (strong, nonatomic) NSString *pressue_applied;
@property (strong, nonatomic) NSString *position_x;
@property (strong, nonatomic) NSString *postion_y;
@property (strong, nonatomic) NSString *t_delay_press_character;

- (void)dummyData;

- (int)intValumeFromCharacter:(unichar)character;
- (int)characterType:(unichar)character;
- (void)functionTest;

@end
