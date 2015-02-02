//
//  DataBase.h
//  Sample
//
//  Created by wangkun on 15/2/1.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordObject.h"

@interface DataBase : NSObject

+(NSString *)databaseFilePath;
+(NSString *)databaseDirectory;
+(BOOL)creatAllTables;

+(BOOL)insertRecord:(RecordObject *)recordObj;
+(void)exportAllRecords;

@end
