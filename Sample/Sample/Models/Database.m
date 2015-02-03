//
//  DataBase.m
//  Sample
//
//  Created by wangkun on 15/2/1.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

#import "DataBase.h"
#import "FMDatabase.h"
#import "AppDefine.h"
#import "RecordObject.h"

@implementation DataBase

+(NSString *)databaseDirectory
{
    NSString *dbPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    dbPath = [dbPath stringByAppendingString:kDBFilePath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:dbPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return dbPath;
}

+(NSString *)databaseFilePath
{
    return [[DataBase databaseDirectory] stringByAppendingString:kDBFileName];
}

+ (NSString *)csvFileNameByTimeStamp
{
    NSInteger timestamp = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    NSString *csvFileName = [NSString stringWithFormat:@"%ld.csv", timestamp];
    
    return csvFileName;
}

+(NSString *)csvFilePath
{
    return [[DataBase databaseDirectory] stringByAppendingString:[DataBase csvFileNameByTimeStamp]];
}

+(BOOL)creatAllTables
{
    BOOL result = FALSE;
    
    FMDatabase *db = [FMDatabase databaseWithPath:[DataBase databaseFilePath]];
    
    if ([db open])
    {
        result = [db executeUpdate:kDataBaseInitSqlite];
        
        [db close];
    }
    
    return result;
}

+(BOOL)insertRecord:(RecordObject *)recordObj;
{
    BOOL result = FALSE;
    
    FMDatabase *db = [FMDatabase databaseWithPath:[DataBase databaseFilePath]];
    if ([db open])
    {
        [db beginTransaction];
        
        result = [db executeUpdate:@"INSERT INTO record (user_id, user_name, character_id, character_type, time_lp_on_character, time_lp_press, pressue_applied, position_x, postion_y, t_delay_press_character) VALUES (?,?,?,?,?,?,?,?,?,?)",
                  recordObj.user_id,
                  recordObj.user_name,
                  recordObj.character_id,
                  recordObj.character_type,
                  recordObj.time_lp_on_character,
                  recordObj.time_lp_press,
                  recordObj.pressue_applied,
                  recordObj.position_x,
                  recordObj.postion_y,
                  recordObj.t_delay_press_character];
        
        
        [db commit];
        [db close];
    }
    
    return result;
}

+(void)exportAllRecords
{    
    //init database
    FMDatabase *db = [FMDatabase databaseWithPath:[DataBase databaseFilePath]];;
    
    if ([db open])
    {
        FMResultSet *results = [db executeQuery:@"SELECT * FROM record"];
        
        NSString *csvFilePath = [DataBase csvFilePath];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:csvFilePath])
        {
            [[NSFileManager defaultManager] createFileAtPath: csvFilePath contents:nil attributes:nil];
        }
        
        NSMutableString *writeString = [NSMutableString string];
        
        while([results next]) {
            NSDictionary *resultDic = [results resultDictionary];
            NSArray *values = [resultDic allValues];
            
            NSMutableString *strFromColumn = [NSMutableString string];
            for (NSString *val in values)
            {
                [strFromColumn appendFormat:@"%@, ",val];
            }
            
            [strFromColumn appendString:@"\n"];
            
            [writeString appendString:strFromColumn];
        }
        
        NSLog(@"%@", writeString);
        
        NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:csvFilePath];
        //say to handle where's the file fo write
        [handle truncateFileAtOffset:[handle seekToEndOfFile]];
        //position handle cursor to the end of file
        [handle writeData:[writeString dataUsingEncoding:NSUTF8StringEncoding]];
        
        [handle closeFile];
        
        [db close];
    }
}

@end
