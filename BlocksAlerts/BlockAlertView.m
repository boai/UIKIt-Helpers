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
        
        self.returnButton = -1;
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
    
    if (_alertView.alertViewStyle!=UIAlertViewStyleDefault && _alertView.alertViewStyle!=UIAlertViewStylePlainTextInput)
    {
        [_alertView textFieldAtIndex:0].delegate = self;
        [_alertView textFieldAtIndex:1].delegate = self;
    }
    else if (_alertView.alertViewStyle == UIAlertViewStylePlainTextInput)
    {
        [_alertView textFieldAtIndex:0].delegate = self;
    }
    
    [_alertView show];
}

-(void)dissmissed
{
    context = nil;
    _alertView = nil;
}

-(void)didDismissWithButton:(int)button
{
    void(^block)(BlockAlertView*) = buttonsBlocks[button];
    block(self);
    
    [self dissmissed];
}

#pragma mark - Properties

-(void)setCancelButtonIndex:(int)cancelButtonIndex
{
    _alertView.cancelButtonIndex = cancelButtonIndex;
}

-(int)cancelButtonIndex
{
    return _alertView.cancelButtonIndex;
}

-(UITextField*)textFieldAtIndex:(int)index
{
    return [_alertView textFieldAtIndex:index];
}

-(void)setStyle:(UIAlertViewStyle)style
{
    _alertView.alertViewStyle = style;
}

-(UIAlertViewStyle)style
{
    return _alertView.alertViewStyle;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self didDismissWithButton:buttonIndex];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == [_alertView textFieldAtIndex:0])
    {
        if (_alertView.alertViewStyle==UIAlertViewStyleLoginAndPasswordInput)
        {
            [[_alertView textFieldAtIndex:1] becomeFirstResponder];
            return YES;
        }
    }
    
    if (self.returnButton<0) return NO;
    
    [_alertView dismissWithClickedButtonIndex:self.returnButton animated:YES];
    
    return YES;
}

@end
