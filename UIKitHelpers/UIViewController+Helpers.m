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

@end
