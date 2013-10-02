//
//  UIViewController+CloseButton.m
//  photomovie
//
//  Created by Evgeny Rusanov on 10.07.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "UIViewController+CloseButton.h"

@implementation UIViewController (CloseButton)

-(void)closeClick
{
    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
}

-(void)addCloseButtonWithTitle:(NSString*)title
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(closeClick)];
}

-(void)addCloseButton
{
    [self addCloseButtonWithTitle:NSLocalizedString(@"Close", @"")];
}

@end
