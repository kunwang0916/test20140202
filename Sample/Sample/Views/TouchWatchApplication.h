//
//  TouchWatchApplication.h
//  Sample
//
//  Created by wangkun on 15/2/2.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchWatchApplication : UIApplication
@end

@protocol TouchWatchApplicationDelegate <UIApplicationDelegate>
- (void)application:(TouchWatchApplication *)application willSendTouchEvent:(UIEvent *)event;
@end

