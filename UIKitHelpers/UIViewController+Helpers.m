//
//  UIViewController+Helpers.m
//  photomovie
//
//  Created by Evgeny Rusanov on 06.09.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "UIViewController+Helpers.h"

@implementation UIViewController (Helpers)

-(UIViewController*)findTopViewController
{
    UIViewController *result = self;
    
    while (result.presentedViewController)
        result = result.presentedViewController;
    
    return result;
}

-(UIBarButtonItem*)customBarButtonItemWithImageName:(NSString*)imageName action:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:imageName];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
