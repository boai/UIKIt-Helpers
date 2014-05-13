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
-(void)addButton:(NSString*)title withBlock:(void (^)(BlockActionSheet* alert, NSInteger buttonIndex))block;

-(void)showFromTabBar:(UITabBar*)tabbar;
-(void)showFromToolBar:(UIToolbar*)toolbar;
-(void)showInView:(UIView*)view;
-(void)showFromBarButtonItem:(UIBarButtonItem*)barButton animated:(BOOL)animated;
-(void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated;

@property (nonatomic) NSInteger cancelButtonIndex;
@property (nonatomic) NSInteger destructiveButtonIndex;
@property (nonatomic,readonly) NSInteger numberOfButtons;
@property (nonatomic,strong,readonly) UIActionSheet *actionSheet;

@end
