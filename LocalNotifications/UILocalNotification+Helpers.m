//
//  UILocalNotification+Helpers.m
//  photomovie
//
//  Created by Evgeny Rusanov on 24.11.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "UILocalNotification+Helpers.h"

@implementation UILocalNotification (Helpers)

-(void)recheduleFireTime:(NSDate*)fireTime
{
    [[UIApplication sharedApplication] cancelLocalNotification:self];
    self.fireDate = fireTime;
    [[UIApplication sharedApplication] scheduleLocalNotification:self];
}

-(void)recheduleRepeat:(NSCalendarUnit)calendarUnit
{
    [[UIApplication sharedApplication] cancelLocalNotification:self];
    self.repeatInterval = calendarUnit;
    [[UIApplication sharedApplication] scheduleLocalNotification:self];
}

+(UILocalNotification*)createLocalNotification:(NSDate*)fireDate
                                     alertBody:(NSString*)alertBody
                                   alertAction:(NSString*)alertAction
                                      userInfo:(NSDictionary*)userInfo
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.fireDate = fireDate;
    notification.alertBody = alertBody;
    notification.alertAction = alertAction;
    notification.repeatInterval = 0;
    notification.soundName = UILocalNotificationDefaultSoundName;

    notification.userInfo = userInfo;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    return notification;
}

@end
