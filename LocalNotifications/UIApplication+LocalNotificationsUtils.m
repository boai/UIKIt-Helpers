//
//  UIApplication+LocalNotificationsUtils.m
//  photomovie
//
//  Created by Evgeny Rusanov on 16.08.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "UIApplication+LocalNotificationsUtils.h"

@implementation UIApplication (LocalNotificationsUtils)

-(UILocalNotification*)localNotificationForKey:(NSString*)key
{
    NSArray *notifications = self.scheduledLocalNotifications;
    
    for (UILocalNotification *n in notifications)
    {
        if ([[n.userInfo valueForKey:@"key"] isEqualToString:key])
            return n;
    }
    
    return nil;
}

@end
