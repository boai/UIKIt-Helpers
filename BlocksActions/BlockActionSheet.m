//
//  BlockActionSheet.m
//  photomovie
//
//  Created by Evgeny Rusanov on 31.07.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "BlockActionSheet.h"

@interface BlockActionSheet ()

@property (nonatomic,copy) void (^cancelButtonBlock)(BlockActionSheet* alert, NSInteger buttonIndex);

@end

@implementation BlockActionSheet
{
    NSMutableArray *_buttonsBlocks;
    
    id _context;
}

-(void)addButton:(NSString*)title withBlock:(void (^)(BlockActionSheet* alert, NSInteger buttonIndex))block
{
    [_actionSheet addButtonWithTitle:title];
    if (block)
        [_buttonsBlocks addObject:[block copy]];
    else
    {
        [_buttonsBlocks addObject:[self.emptyBlock copy]];
    }
}

-(void)addCancelButton:(NSString *)title withBlock:(void (^)(BlockActionSheet *, NSInteger))block
{
    [_actionSheet addButtonWithTitle:title];
    if (block)
        self.cancelButtonBlock = block;
}

-(void(^)(BlockActionSheet* alert, NSInteger buttonIndex))emptyBlock
{
    return ^(BlockActionSheet* alert, NSInteger buttonIndex) {};
}

-(id)init
{
    return [self initWithTitle:nil];
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
        _buttonsBlocks = [[NSMutableArray alloc] init];
        self.cancelButtonBlock = self.emptyBlock;
    }
    return self;
}

-(void)showFromTabBar:(UITabBar*)tabbar
{
    _context = self;
    [_actionSheet showFromTabBar:tabbar];
}

-(void)showFromToolBar:(UIToolbar*)toolbar
{
    _context = self;
    [_actionSheet showFromToolbar:toolbar];
}

-(void)showInView:(UIView*)view
{
    _context = self;
    [_actionSheet showInView:view];
}

-(void)showFromBarButtonItem:(UIBarButtonItem*)barButton animated:(BOOL)animated
{
    _context = self;
    [_actionSheet showFromBarButtonItem:barButton animated:animated];
}

-(void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated
{
    _context = self;
    [_actionSheet showFromRect:rect inView:view animated:animated];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    void(^block)(BlockActionSheet*,NSInteger) = nil;
    
    NSInteger blockIndex = buttonIndex;
    
    if (blockIndex < 0 || blockIndex >= _buttonsBlocks.count || blockIndex == self.cancelButtonIndex)
        block = self.cancelButtonBlock;
    else
        block = [_buttonsBlocks objectAtIndex:blockIndex];
    
    block(self,buttonIndex);
    
    _context = nil;
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
