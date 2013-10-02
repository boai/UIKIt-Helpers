//
//  UILocalNotification+Helpers.h
//  photomovie
//
//  Created by Evgeny Rusanov on 24.11.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILocalNotification (Helpers)

-(void)recheduleFireTime:(NSDate*)fireTime;
-(void)recheduleRepeat:(NSCalendarUnit)calendarUnit;

+(UILocalNotification*)createLocalNotification:(NSDate*)fireDate
                                     alertBody:(NSString*)alertBody
                                   alertAction:(NSString*)alertAction
                                      userInfo:(NSDictionary*)userInfo;

@end
