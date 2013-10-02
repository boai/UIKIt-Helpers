//
//  BlockAlertView.m
//  photomovie
//
//  Created by Evgeny Rusanov on 09.07.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "BlockAlertView.h"

@implementation BlockAlertView
{
    UIAlertView *_alertView;
    
    NSMutableArray *buttonsBlocks;
    
    id context;
}

@synthesize alertView = _alertView;

-(id)initWithTitle:(NSString*)title message:(NSString*)message
{
    if (self = [self init])
    {
        _alertView = [[UIAlertView alloc] initWithTitle:title
                                                message:message
                                               delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil];
        
        buttonsBlocks = [NSMutableArray array];
    }
    return self;
}

-(void)addButton:(NSString*)title withBlock:(void (^)(BlockAlertView*))block
{
    [_alertView addButtonWithTitle:title];
    if (block)
        [buttonsBlocks addObject:[block copy]];
    else
    {
        void(^emptyBlock)(BlockAlertView*) = ^(BlockAlertView* alert) {};
        [buttonsBlocks addObject:[emptyBlock copy]];
    }
}

-(void)show
{
    context = self;
    
    [_alertView show];
}

#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void(^block)(BlockAlertView*) = [buttonsBlocks objectAtIndex:buttonIndex];
    
    block(self);
    
    context = nil;
    _alertView = nil;
}

@end
