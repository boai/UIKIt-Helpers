//
//  UIApplication+LocalNotificationsUtils.h
//  photomovie
//
//  Created by Evgeny Rusanov on 16.08.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (LocalNotificationsUtils)

-(UILocalNotification*)localNotificationForKey:(NSString*)key;

@end
