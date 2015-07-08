//
//  BlockActionSheet.h
//  photomovie
//
//  Created by Evgeny Rusanov on 31.07.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockActionSheet : NSObject <UIActionSheetDelegate>

@property (nonatomic,readonly) NSInteger numberOfButtons;

-(instancetype)initWithTitle:(NSString*)title;
-(void)addButton:(NSString*)title withBlock:(void (^)(BlockActionSheet* alert, NSInteger buttonIndex))block;
-(void)addCancelButton:(NSString*)title withBlock:(void (^)(BlockActionSheet* alert, NSInteger buttonIndex))block;
-(void)addDestructiveButton:(NSString*)title withBlock:(void (^)(BlockActionSheet* alert, NSInteger buttonIndex))block;

-(void)showFromTabBar:(UITabBar*)tabbar;
-(void)showFromToolBar:(UIToolbar*)toolbar;
-(void)showInView:(UIView*)view;
-(void)showFromBarButtonItem:(UIBarButtonItem*)barButton animated:(BOOL)animated;
-(void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated;

@end
