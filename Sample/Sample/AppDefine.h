//
//  AppDefine.h
//  Sample
//
//  Created by wangkun on 15/2/1.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

#ifndef Sample_AppDefine_h
#define Sample_AppDefine_h


#define kDBFileName     @"sample.db"
#define kDBFilePath     @"/database/"

#define kDataBaseInitSqlite   @"CREATE TABLE IF NOT EXISTS \"record\" (\"id\" integer NOT NULL PRIMARY KEY AUTOINCREMENT,\"user_id\" integer NOT NULL DEFAULT 0,\"user_name\" text DEFAULT NULL,\"character_id\" integer NOT NULL,\"character_type\" integer NOT NULL,\"time_lp_on_character\" integer NOT NULL,\"time_lp_press\" integer NOT NULL,\"pressue_applied\" integer NOT NULL,\"position_x\" integer NOT NULL DEFAULT 0,\"postion_y\" integer NOT NULL DEFAULT 0,\"t_delay_press_character\" integer NOT NULL DEFAULT 0);"

#endif
