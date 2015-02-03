//
//  TouchWatchApplication.m
//  Sample
//
//  Created by wangkun on 15/2/2.
//  Copyright (c) 2015年 wangkun. All rights reserved.
//

#import "TouchWatchApplication.h"

@implementation TouchWatchApplication

- (void)sendEvent:(UIEvent *)event {
    if (event.type == UIEventTypeTouches) {
        id<TouchWatchApplicationDelegate> delegate = (id<TouchWatchApplicationDelegate>)self.delegate;
        [delegate application:self willSendTouchEvent:event];
    }
    [super sendEvent:event];
}


@end

