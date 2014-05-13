//
//  BlockActionSheet.m
//  photomovie
//
//  Created by Evgeny Rusanov on 31.07.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "BlockActionSheet.h"

@implementation BlockActionSheet
{
    NSMutableArray *buttonsBlocks;
    
    id context;
}

-(void)addButton:(NSString*)title withBlock:(void (^)(BlockActionSheet* alert, NSInteger buttonIndex))block
{
    [_actionSheet addButtonWithTitle:title];
    if (block)
        [buttonsBlocks addObject:[block copy]];
    else
    {
        void(^emptyBlock)(BlockActionSheet*, NSInteger buttonIndex) = ^(BlockActionSheet* alert, NSInteger buttonIndex) {};
        [buttonsBlocks addObject:[emptyBlock copy]];
    }
}

-(id)initWithTitle:(NSString *)title
{
    if (self = [super init])
    {
        _actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                   delegate:self
                                          cancelButtonTitle:nil
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:nil];
        buttonsBlocks = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)showFromTabBar:(UITabBar*)tabbar
{
    context = self;
    [_actionSheet showFromTabBar:tabbar];
}

-(void)showFromToolBar:(UIToolbar*)toolbar
{
    context = self;
    [_actionSheet showFromToolbar:toolbar];
}

-(void)showInView:(UIView*)view
{
    context = self;
    [_actionSheet showInView:view];
}

-(void)showFromBarButtonItem:(UIBarButtonItem*)barButton animated:(BOOL)animated
{
    context = self;
    [_actionSheet showFromBarButtonItem:barButton animated:animated];
}

-(void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated
{
    context = self;
    [_actionSheet showFromRect:rect inView:view animated:animated];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    void(^block)(BlockActionSheet*,NSInteger) = [buttonsBlocks objectAtIndex:buttonIndex];
    
    block(self,buttonIndex);
    
    context = nil;
    _actionSheet = nil;
}

#pragma mark - Properties

-(void)setCancelButtonIndex:(NSInteger)cancelButtonIndex
{
    _actionSheet.cancelButtonIndex = cancelButtonIndex;
}

-(NSInteger)cancelButtonIndex
{
    return _actionSheet.cancelButtonIndex;
}

-(void)setDestructiveButtonIndex:(NSInteger)destructiveButtonIndex
{
    _actionSheet.destructiveButtonIndex = destructiveButtonIndex;
}

-(NSInteger)destructiveButtonIndex
{
    return _actionSheet.destructiveButtonIndex;
}

-(NSInteger)numberOfButtons
{
    return _actionSheet.numberOfButtons;
}


@end
