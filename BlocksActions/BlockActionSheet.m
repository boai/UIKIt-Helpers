//
//  BlockActionSheet.m
//  photomovie
//
//  Created by Evgeny Rusanov on 31.07.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "BlockActionSheet.h"

@interface BlockActionSheet () <UIPopoverPresentationControllerDelegate>

@property (nonatomic,copy) void (^cancelButtonBlock)(BlockActionSheet* alert, NSInteger buttonIndex);

@property (nonatomic,strong) UIActionSheet *actionSheet;
@property (nonatomic,strong) UIAlertController *alertController;

@end

@implementation BlockActionSheet
{
    NSMutableArray *_buttonsBlocks;
    
    id _context;
}

-(void)addButton:(NSString*)title withBlock:(void (^)(BlockActionSheet* alert, NSInteger buttonIndex))block
{
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0)
    {
        [_actionSheet addButtonWithTitle:title];
        if (block)
            [_buttonsBlocks addObject:[block copy]];
        else
        {
            [_buttonsBlocks addObject:[self.emptyBlock copy]];
        }
    }
    else
    {
        typeof(self) __weak weakSelf = self;
        UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           [weakSelf performAction:action withBlock:block];
                                                       }];
        [_alertController addAction:action];
    }
}

-(void)addCancelButton:(NSString *)title withBlock:(void (^)(BlockActionSheet *, NSInteger))block
{
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0)
    {
        NSInteger indx = [_actionSheet addButtonWithTitle:title];
        _actionSheet.cancelButtonIndex = indx;
        if (block)
            self.cancelButtonBlock = block;
    }
    else
    {
        typeof(self) __weak weakSelf = self;
        UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction *action) {
                                                           [weakSelf performAction:action withBlock:block];
                                                       }];
        [_alertController addAction:action];
    }
}

-(void)addDestructiveButton:(NSString *)title withBlock:(void (^)(BlockActionSheet *, NSInteger))block
{
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0)
    {
        NSInteger indx = [_actionSheet addButtonWithTitle:title];
        _actionSheet.destructiveButtonIndex = indx;
        if (block)
            [_buttonsBlocks addObject:[block copy]];
        else
        {
            [_buttonsBlocks addObject:[self.emptyBlock copy]];
        }
    }
    else
    {
        typeof(self) __weak weakSelf = self;
        UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                         style:UIAlertActionStyleDestructive
                                                       handler:^(UIAlertAction *action) {
                                                           [weakSelf performAction:action withBlock:block];
                                                       }];
        [_alertController addAction:action];
    }
}

-(void)performAction:(UIAlertAction *)action withBlock:(void (^)(BlockActionSheet* alert, NSInteger buttonIndex))block
{
    if (block)
    {
        block(self,[_alertController.actions indexOfObject:action]);
    }
    _alertController = nil;
}

-(void(^)(BlockActionSheet* alert, NSInteger buttonIndex))emptyBlock
{
    return ^(BlockActionSheet* alert, NSInteger buttonIndex) {};
}

-(instancetype)init
{
    return [self initWithTitle:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(BOOL)oldStyle
{
    return [[UIDevice currentDevice].systemVersion floatValue] < 8.0;
}

-(instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
        if (self.oldStyle)
        {
            _actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                       delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil];
            _buttonsBlocks = [[NSMutableArray alloc] init];
            self.cancelButtonBlock = self.emptyBlock;
        }
        else
        {
            _alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            _alertController.popoverPresentationController.delegate = self;
            
        }
    }
    return self;
}

-(void)showFromTabBar:(UITabBar*)tabbar
{
    _context = self;
    if (self.oldStyle)
    {
        [_actionSheet showFromTabBar:tabbar];
    }
    else
    {
        _alertController.popoverPresentationController.sourceRect = tabbar.bounds;
        [self present];
    }
}

-(void)showFromToolBar:(UIToolbar*)toolbar
{
    _context = self;
    if (self.oldStyle)
    {
        [_actionSheet showFromToolbar:toolbar];
    }
    else
    {
        _alertController.popoverPresentationController.sourceRect = toolbar.bounds;
        [self present];
    }
}

-(void)showInView:(UIView*)view
{
    _context = self;
    if (self.oldStyle)
    {
        [_actionSheet showInView:view];
    }
    else
    {
        _alertController.popoverPresentationController.sourceView = view;
        _alertController.popoverPresentationController.sourceRect = view.bounds;
        
        [self present];
    }
}

-(void)showFromBarButtonItem:(UIBarButtonItem*)barButton animated:(BOOL)animated
{
    _context = self;
    if (self.oldStyle)
    {
        [_actionSheet showFromBarButtonItem:barButton animated:animated];
    }
    else
    {
        _alertController.popoverPresentationController.barButtonItem = barButton;
        [self present];
    }
}

-(void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated
{
    _context = self;
    if (self.oldStyle)
    {
        [_actionSheet showFromRect:rect inView:view animated:animated];
    }
    else
    {
        _alertController.popoverPresentationController.sourceRect = rect;
        _alertController.popoverPresentationController.sourceView = view;
        [self present];
    }
}

- (UIViewController *) getRootController
{
    NSMutableArray *windows = [[UIApplication sharedApplication].windows mutableCopy];
    
    UIWindow *window = windows.lastObject;
    UIViewController *rootController = nil;
    
    while (window && rootController == nil) {
        rootController = window.rootViewController;
        if (rootController == nil)
        {
            [windows removeLastObject];
            window = windows.lastObject;
        }
    }
    
    return rootController;
}

-(void)present
{
    UIViewController *rootController = [self getRootController];
    
    [rootController presentViewController:_alertController
                                 animated:YES
                               completion:nil];
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
    
    _actionSheet = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        _context = nil;
    });
}

-(void)dismiss
{
    if (self.oldStyle)
    {
        [_actionSheet dismissWithClickedButtonIndex:-1 animated:YES];
    }
    else
    {
        [_alertController dismissViewControllerAnimated:YES completion:nil];
    }
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
    if (self.oldStyle)
        return _actionSheet.numberOfButtons;
    else
    {
        return _alertController.actions.count;
    }
}

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _context = nil;
    });
}
@end
