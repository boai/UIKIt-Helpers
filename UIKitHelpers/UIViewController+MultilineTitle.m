//
//  UIViewController+MultilineTitle.m
//  photoexplorer
//
//  Created by Evgeny Rusanov on 03.11.14.
//  Copyright (c) 2014 Evgeny Rusanov. All rights reserved.
//

#import "UIViewController+MultilineTitle.h"

@implementation UIViewController (MultilineTitle)

-(void)setMultilineTitle:(NSString*)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               0,
                                                               self.navigationController.navigationBar.bounds.size.width-100,
                                                               self.navigationController.navigationBar.bounds.size.height)];
    label.text = title;
    label.numberOfLines = 2;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.font = [UIFont systemFontOfSize:14];
    label.minimumScaleFactor = 0.5f;
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = label;
}

-(void)updateMultilineTitle:(NSString*)title
{
    UILabel *label = (UILabel*)self.navigationItem.titleView;
    label.text = title;
}

-(void)convertTitleToMultiline
{
    [self setMultilineTitle:self.title];
}

-(void)setMultilineTitleColor:(UIColor*)color
{
    UILabel *label = (UILabel*)self.navigationItem.titleView;
    label.textColor = color;
}

@end
