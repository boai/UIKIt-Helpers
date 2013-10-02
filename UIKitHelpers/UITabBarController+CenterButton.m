//
//  UITabBarController+CenterButton.m
//  photomovie
//
//  Created by Evgeny Rusanov on 18.07.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "UITabBarController+CenterButton.h"

@implementation UITabBarController (CenterButton)

-(void)addCenterButton:(UIButton*)button
{
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    CGSize size;
    if ([button imageForState:UIControlStateNormal])
        size = [button imageForState:UIControlStateNormal].size;
    else
        size = button.frame.size;
    
    button.frame = CGRectMake(0.0, 0.0, size.width, size.height);
    
    CGFloat heightDifference = size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        button.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    
    [self.tabBar addSubview:button];
}

@end
