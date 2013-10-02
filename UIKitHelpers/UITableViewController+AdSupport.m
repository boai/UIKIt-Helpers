//
//  UITableViewController+AdSupport.m
//  VideoDownloader
//
//  Created by Evgeny Rusanov on 26.10.12.
//  Copyright (c) 2012 Kain. All rights reserved.
//

#import "UITableViewController+AdSupport.h"

#import <iAd/iAd.h>
#include <objc/runtime.h>

#define BANNER_TAG      1001
#define TABLEVIEW_TAG   1002

#define ADBANNER_POSITION_KEY       "ADBANNER_POSITION_KEY"

@implementation UITableViewController (AdSupport)

-(UITableView*)tableView
{
    if ([self.view isKindOfClass:[UITableView class]])
        return (UITableView*)[self view];
    
    return (UITableView*)[self.view viewWithTag:TABLEVIEW_TAG];
}

-(int)banner_position
{
    NSNumber *n = objc_getAssociatedObject(self, ADBANNER_POSITION_KEY);
    if (!n || n.intValue>2)
        return 2;
    return n.intValue;
}
-(void)addAdBannerPosition:(int)pos
{
    if ([self.view isKindOfClass:[UITableView class]])
    {
        NSNumber *n = [NSNumber numberWithInt:pos];
        objc_setAssociatedObject(self, ADBANNER_POSITION_KEY, n, OBJC_ASSOCIATION_RETAIN);
        
        UITableView *t = self.tableView;
        
        UIView *v = [[UIView alloc] initWithFrame:self.view.frame];
        v.backgroundColor = [UIColor clearColor];
        v.autoresizingMask = self.view.autoresizingMask;
        
        t.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        t.tag = TABLEVIEW_TAG;
        
        self.view = v;
        [self.view addSubview:t];
        
        ADBannerView *banner = [[ADBannerView alloc] initWithFrame:CGRectZero];
        
        CGRect r = banner.frame;
        if (pos==ADBANNER_POSITION_TOP)
            r.origin.y=-50;
        else
            r.origin.y=self.view.frame.size.height;
        banner.frame = r;
        banner.delegate = (id<ADBannerViewDelegate>)self;
        banner.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        banner.tag = BANNER_TAG;
        
        [self updateBannerOrientation:banner interfaceOrientation:self.interfaceOrientation];
        
        [self.view insertSubview:banner atIndex:0];
    }
}

-(void)addAdBanner
{
    [self addAdBannerPosition:ADBANNER_POSITION_BOTTOM];
}

-(void)removeAdBanner
{
    ADBannerView *banner = (ADBannerView*)[self.view viewWithTag:BANNER_TAG];
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self setFramesForNotLoadedBanner:banner];
                     } completion:^(BOOL finished) {
                         [banner removeFromSuperview];
                     }];
}

-(void)addUpgradeObserver:(NSString*)notificationName
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(upgradeComplete:)
                                                 name:notificationName
                                               object:nil];
}

-(void)upgradeComplete:(NSNotification*)n
{
    [self removeAdBanner];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

-(void)updateBannerOrientation:(ADBannerView*)banner interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([banner respondsToSelector:@selector(currentContentSizeIdentifier)])
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
            banner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
        else
            banner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    }
}

-(void)setFramesForLoadedBanner:(ADBannerView*)banner
{
    CGRect bannerFrame = banner.frame;
    if (bannerFrame.size.width>self.view.frame.size.width)
        bannerFrame.size.width = self.view.frame.size.width;
    else
        bannerFrame.origin.x = (self.view.frame.size.width - bannerFrame.size.width)*0.5;
    
    CGRect tableFrame = self.tableView.frame;
    tableFrame.size.height=self.view.frame.size.height - bannerFrame.size.height;
    
    if ([self banner_position]==ADBANNER_POSITION_TOP)
    {
        bannerFrame.origin.y = 0;
        tableFrame.origin.y = bannerFrame.size.height;
    }
    else
    {
        bannerFrame.origin.y=self.view.frame.size.height-bannerFrame.size.height;
        tableFrame.origin.y = 0;
    }
    
    banner.frame = bannerFrame;
    self.tableView.frame = tableFrame;

}

-(void)setFramesForNotLoadedBanner:(ADBannerView*)banner
{
    CGRect r = banner.frame;
    if ([self banner_position]==ADBANNER_POSITION_TOP)
        r.origin.y = -r.size.height;
    else
        r.origin.y=self.view.frame.size.height;
    r.size.width = self.view.frame.size.width;
    banner.frame = r;
    
    self.tableView.frame = self.view.frame;
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"Banner loaded");
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self setFramesForLoadedBanner:banner];
                     }];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Banner load error");
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self setFramesForNotLoadedBanner:banner];
                     }];
}

-(void)setFrames:(UIInterfaceOrientation)orientation
{
    ADBannerView *banner = (ADBannerView*)[self.view viewWithTag:BANNER_TAG];
    
    [self updateBannerOrientation:banner interfaceOrientation:orientation];
    
    if (banner.bannerLoaded)
    {
        [self setFramesForLoadedBanner:banner];
    }
    else
    {
        [self setFramesForNotLoadedBanner:banner];
    }
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self setFrames:toInterfaceOrientation];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setFrames:self.interfaceOrientation];
}

@end
