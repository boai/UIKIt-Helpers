//
//  BlockAlertView.m
//  photomovie
//
//  Created by Evgeny Rusanov on 09.07.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "BlockAlertView.h"

typedef enum : NSUInteger {
    BlockAlertViewButtonTypeDefault,
    BlockAlertViewButtonTypeCancel,
} BlockAlertViewButtonType;

@interface BlockAlertView () <UIAlertViewDelegate,UITextFieldDelegate>

@property (nonatomic) BOOL forceOldVersion;

@end

@implementation BlockAlertView
{
    UIAlertView *_alertView;
    
    NSMutableArray *buttonsBlocks;
    
    id context;
    
    UIAlertController *_alertController;
    BlockAlertViewStyle _style;
}

#pragma mark - IOS 8

-(instancetype)initIOS8WithTitle:(NSString *)title message:(NSString *)message style:(BlockAlertViewStyle)style
{
    if (self = [super init])
    {
        _alertController = [UIAlertController alertControllerWithTitle:title
                                                               message:message
                                                        preferredStyle:UIAlertControllerStyleAlert];
        
        switch (style) {
            case BlockAlertViewStyleLoginAndPasswordInput:
                [self addLoginAndPaswordFields];
                break;
                
            case BlockAlertViewStylePlainTextInput:
                [self addPlainTextInput];
                break;
                
            case BlockAlertViewStyleSecureTextInput:
                [self addSecureTextInput];
                break;
            default:
                break;
        }
    }
    
    return self;
}

-(void)addLoginAndPaswordFields
{
    typeof(self) __weak weakSelf = self;
    [_alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.delegate = weakSelf;
    }];
    
    [_alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.secureTextEntry = YES;
        textField.delegate = weakSelf;
    }];
}

-(void)addPlainTextInput
{
    typeof(self) __weak weakSelf = self;
    [_alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.delegate = weakSelf;
    }];
}

-(void)addSecureTextInput
{
    typeof(self) __weak weakSelf = self;
    [_alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.secureTextEntry = YES;
        textField.delegate = weakSelf;
    }];
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message forceOldStyle:(BOOL)forceOldStyle
{
    return [self initWithTitle:title message:message style:BlockAlertViewStyleDefault forceOldStyle:forceOldStyle];
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    return [self initWithTitle:title message:message style:BlockAlertViewStyleDefault forceOldStyle:NO];
}

-(instancetype)initWithTitle:(NSString*)title message:(NSString*)message style:(BlockAlertViewStyle)style
{
    return [self initWithTitle:title message:message style:style forceOldStyle:NO];
}

-(instancetype)initWithTitle:(NSString*)title message:(NSString*)message style:(BlockAlertViewStyle)style forceOldStyle:(BOOL)forceOldStyle
{
    if (self = [self init])
    {
        _forceOldVersion = forceOldStyle;
        _style = style;
        if (self.useOldInterface)
        {
            _alertView = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
            
            buttonsBlocks = [NSMutableArray array];
            _alertView.alertViewStyle = (UIAlertViewStyle)style;
        }
        else
        {
            self = [self initIOS8WithTitle:title message:message style:style];
        }
    }
    return self;
}

-(BOOL)useOldInterface
{
    return self.forceOldVersion || [[UIDevice currentDevice].systemVersion floatValue] < 8.0;
}

-(void)addButton:(NSString*)title withBlock:(void (^)(BlockAlertView*))block
{
    [self addButton:title buttonType:BlockAlertViewButtonTypeDefault withBlock:block];
}

-(void)addCancelButton:(NSString *)title withBlock:(void (^)(BlockAlertView *))block
{
    [self addButton:title buttonType:BlockAlertViewButtonTypeCancel withBlock:block];
}

-(void)addButton:(NSString *)title buttonType:(BlockAlertViewButtonType)type withBlock:(void (^)(BlockAlertView *))block
{
    if (self.useOldInterface)
    {
        NSInteger indx = [_alertView addButtonWithTitle:title];
        
        if (type == BlockAlertViewButtonTypeCancel)
            _alertView.cancelButtonIndex = indx;
        
        if (block)
            [buttonsBlocks addObject:[block copy]];
        else
        {
            void(^emptyBlock)(BlockAlertView*) = ^(BlockAlertView* alert) {};
            [buttonsBlocks addObject:[emptyBlock copy]];
        }
    }
    else
    {
        typeof(self) __weak weakSelf = self;
        
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        if (type == BlockAlertViewButtonTypeCancel)
        {
            style = UIAlertActionStyleCancel;
        }
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction *action) {
            if (block)
                block(weakSelf);
            [weakSelf dissmissed];
        }];
        [_alertController addAction:action];
    }
}

-(void)show
{
    context = self;
    
    if (self.useOldInterface)
    {
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
    else
    {
        [self present];
    }
}

-(UIViewController *)getRootController
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    
    for (UIView *subView in [window subviews])
    {
        UIResponder *responder = [subView nextResponder];
        if([responder isKindOfClass:[UIViewController class]]) {
            return [self topMostViewController: (UIViewController *) responder];
        }
    }
    
    return nil;
}

- (UIViewController *) topMostViewController: (UIViewController *) controller {
    BOOL isPresenting = NO;
    do {
        // this path is called only on iOS 6+, so -presentedViewController is fine here.
        UIViewController *presented = [controller presentedViewController];
        isPresenting = presented != nil;
        if(presented != nil) {
            controller = presented;
        }
        
    } while (isPresenting);
    
    return controller;
}

-(void)present
{
    UIViewController *rootController = [self getRootController];
    if (rootController == nil)
    {
        rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
        rootController = [self topMostViewController:rootController];
    }
    [rootController presentViewController:_alertController
                                 animated:YES
                               completion:^{
                                   [self didPresent];
                               }];
}

-(void)dissmissed
{
    if (self.useOldInterface)
    {
        _alertView = nil;
    }
    else
    {
        _alertController = nil;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        context = nil;
    });
}

-(void)didDismissWithButton:(NSInteger)button
{
    void(^block)(BlockAlertView*) = buttonsBlocks[button];
    block(self);
    
    [self dissmissed];
}

#pragma mark - Properties

-(UITextField*)textFieldAtIndex:(NSInteger)index
{
    if (self.useOldInterface)
    {
        return [_alertView textFieldAtIndex:index];
    }
    else
    {
        return _alertController.textFields[index];
    }
}

-(NSInteger)numberOfButtons
{
    if (self.useOldInterface)
    {
        return _alertView.numberOfButtons;
    }
    else
    {
        return _alertController.actions.count;
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self didDismissWithButton:buttonIndex];
}

-(void)didPresentAlertView:(UIAlertView *)alertView
{
    [self didPresent];
}

-(void)didPresent
{
    if (self.alertDidShowBlock)
    {
        self.alertDidShowBlock(self);
    }
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == [self textFieldAtIndex:0])
    {
        if (_style == BlockAlertViewStyleLoginAndPasswordInput)
        {
            [[self textFieldAtIndex:1] becomeFirstResponder];
            return YES;
        }
    }
    
    if (self.alertShouldDismissOnTextFieldReturnWithCompletionBlock)
    {
        BOOL shouldDissmiss = self.alertShouldDismissOnTextFieldReturnWithCompletionBlock(self,textField);
        
        if (shouldDissmiss)
        {
            if (self.useOldInterface)
            {
                [_alertView dismissWithClickedButtonIndex:-10 animated:YES];
                if (self.alertDismissOnTextFieldReturnBlock)
                {
                    self.alertDismissOnTextFieldReturnBlock(self,textField);
                }
            }
            else
            {
                __weak typeof(self) weakSelf = self;
                [_alertController dismissViewControllerAnimated:YES completion:^{
                    if (weakSelf.alertDismissOnTextFieldReturnBlock)
                    {
                        weakSelf.alertDismissOnTextFieldReturnBlock(self,textField);
                    }
                }];
            }
        }
    }
    
    return YES;
}

@end
