//
//  AppDelegate.m
//  Sample
//
//  Created by wangkun on 15/2/1.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

#import "AppDelegate.h"
#import "FMDatabase.h"
#import "Database.h"
#import "AppDefine.h"

@interface AppDelegate ()
{
    NSTimeInterval lastTouchStartTimeStamp;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [DataBase creatAllTables];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Custom AppDelegate
- (void)application:(TouchWatchApplication *)application willSendTouchEvent:(UIEvent *)event
{
    NSSet* allTouches = [event allTouches];
    UITouch* touch = [allTouches anyObject];
    UIView* touchView = [touch view];

    if( [NSStringFromClass([touchView class]) isEqualToString:@"UIKeyboardLayoutStar"] )
    {
        //touch event in keyboard
        if (touch.phase == UITouchPhaseBegan)
        {
            lastTouchStartTimeStamp = touch.timestamp;
        }
        if (touch.phase == UITouchPhaseEnded)
        {
            NSTimeInterval nowTimeStamp = touch.timestamp;
            NSNumber *touchDuration = [NSNumber numberWithDouble: ((nowTimeStamp - lastTouchStartTimeStamp) * 1000)];
            NSNumber *touchPressure = [NSNumber numberWithDouble: touch.majorRadius];
            CGPoint touchPoint = [touch locationInView: self.window];
            NSLog(@"touchDuration: %d, touchPressure: %lf, position: %@",[touchDuration intValue], [touchPressure doubleValue], NSStringFromCGPoint(touchPoint));
            
            NSDictionary *touchInfoDic = @{@"duration" : touchDuration,
                                           @"press" : touchPressure,
                                           @"point" : NSStringFromCGPoint(touchPoint)};
            
            NSNotification *n = [NSNotification notificationWithName:kTouchEndInKeyboardNoti object:self userInfo:touchInfoDic];
            [[NSNotificationCenter defaultCenter] postNotification:n];

        }
    }
}


@end
