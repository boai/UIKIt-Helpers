//
//  UITableViewController+Helpers.m
//  photomovie
//
//  Created by Evgeny Rusanov on 09.12.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "UITableViewCell+Helpers.h"

@implementation UITableViewCell (Helpers)

+(CGFloat)groupedCellWidth:(UIInterfaceOrientation)orientation
{
    CGFloat width = 320;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
            width = 1024-110;
        else
            width = 768-110;
    }
    else if (UIInterfaceOrientationIsLandscape(orientation))
    {
        width = 480;
    }
    return width;
}

@end
