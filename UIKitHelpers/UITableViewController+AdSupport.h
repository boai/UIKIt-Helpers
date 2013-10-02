//
//  UITableViewController+AdSupport.h
//  VideoDownloader
//
//  Created by Evgeny Rusanov on 26.10.12.
//  Copyright (c) 2012 Kain. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ADBANNER_POSITION_TOP           1
#define ADBANNER_POSITION_BOTTOM        2

@interface UITableViewController (AdSupport)

-(void)addAdBanner;
-(void)addAdBannerPosition:(int)pos;

-(void)removeAdBanner;

-(void)addUpgradeObserver:(NSString*)notificationName;

@end
