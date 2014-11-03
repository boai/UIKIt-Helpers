//
//  UIViewController+MultilineTitle.h
//  photoexplorer
//
//  Created by Evgeny Rusanov on 03.11.14.
//  Copyright (c) 2014 Evgeny Rusanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MultilineTitle)

-(void)setMultilineTitle:(NSString*)title;
-(void)updateMultilineTitle:(NSString*)title;
-(void)convertTitleToMultiline;
-(void)setMultilineTitleColor:(UIColor*)color;

@end
