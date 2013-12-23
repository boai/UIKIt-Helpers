//
//  BlockActionSheet.h
//  photomovie
//
//  Created by Evgeny Rusanov on 31.07.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockActionSheet : NSObject <UIActionSheetDelegate>

-(id)initWithTitle:(NSString*)title;
-(void)addButton:(NSString*)title withBlock:(void (^)(BlockActionSheet* alert))block;

-(void)showFromTabBar:(UITabBar*)tabbar;
-(void)showFromToolBar:(UIToolbar*)toolbar;
-(void)showInView:(UIView*)view;
-(void)showFromBarButtonItem:(UIBarButtonItem*)barButton animated:(BOOL)animated;
-(void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated;

@property (nonatomic) int cancelButtonIndex;
@property (nonatomic) int destructiveButtonIndex;
@property (nonatomic,readonly) int numberOfButtons;

@end
