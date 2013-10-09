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
    
    CGRect buttonFrame = CGRectMake(0.0, 0.0, size.width, size.height);
    
    CGFloat heightDifference = size.height - self.tabBar.bounds.size.height;
    if (heightDifference < 0)
        buttonFrame.origin.y = (self.tabBar.bounds.size.height - buttonFrame.size.height)*0.5;
    else
        buttonFrame.origin.y = -heightDifference;
    
    buttonFrame.origin.x = (self.tabBar.bounds.size.width - buttonFrame.size.width) * 0.5;
    
    button.frame = buttonFrame;
    
    [self.tabBar addSubview:button];
}

@end
