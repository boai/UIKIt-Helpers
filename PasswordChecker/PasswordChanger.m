//
//  PasswordChanger.m
//  mydiet
//
//  Created by Evgeny Rusanov on 29.12.12.
//  Copyright (c) 2012 Evgeny Rusanov. All rights reserved.
//

#import "PasswordChanger.h"
#import "PasswordChecker.h"

#import "BlockAlertView.h"

@implementation PasswordChanger
{
    BOOL (^oldPassCheckBlock)(NSString* pass);
    void (^completeBlock)(NSString *newPassword, BOOL canceled);
    
    id context;
}

-(void)checkOldPass:(void (^)(void))complete
{
    if (!self.hasOldPassword)
    {
        complete();
        return;
    }
    
    PasswordChecker *checker = [[PasswordChecker alloc] init];
    checker.title = NSLocalizedString(@"Enter old password", @"");
    [checker enterPassword:^BOOL(NSString *pass, BOOL canceled) {
        if (canceled)
        {
            completeBlock(nil, YES);
            context = nil;
            return YES;
        }
        
        if (oldPassCheckBlock)
        {
            complete();
            return YES;
        }
        
        return NO;
    }];
}

-(void)passwordAlertView:(NSString*)title okBlock:(void(^)(BlockAlertView* alert))okBlock
{
    BlockAlertView *passwordAlertView = [[BlockAlertView alloc] initWithTitle:title message:nil];
    passwordAlertView.style = UIAlertViewStyleSecureTextInput;
    [passwordAlertView addButton:NSLocalizedString(@"Cancel", @"") withBlock:^(BlockAlertView *alert) {
        completeBlock(nil,YES);
        context = nil;
    }];
    [passwordAlertView addButton:NSLocalizedString(@"Ok", @"") withBlock:okBlock];
    passwordAlertView.cancelButtonIndex = 0;
    [passwordAlertView show];
}

-(void)enterNewPassword
{
    [self passwordAlertView:NSLocalizedString(@"Enter password", @"") okBlock:^(BlockAlertView *alert) {
        NSString *password = [alert textFieldAtIndex:0].text;
        [self passwordAlertView:NSLocalizedString(@"Confirm password", @"") okBlock:^(BlockAlertView *alert) {
            NSString *confirmPassword = [alert textFieldAtIndex:0].text;
            if ([password isEqualToString:confirmPassword])
            {
                completeBlock(password,NO);
                context = nil;
            }
            else
            {
                BlockAlertView *alert = [[BlockAlertView alloc] initWithTitle:NSLocalizedString(@"Passwords do not match", @"")
                                                                      message:nil];
                [alert addButton:NSLocalizedString(@"Ok", @"") withBlock:^(BlockAlertView *alert) {
                    [self enterNewPassword];
                }];
                [alert show];
            }
        }];
    }];
}

-(void)changePassword:(BOOL (^)(NSString* pass))oldPassCheck complete:(void (^)(NSString *newPassword, BOOL canceled))complete
{
    context = self;
    
    oldPassCheckBlock = [oldPassCheck copy];
    completeBlock = [complete copy];
    
    [self checkOldPass:^{
        [self enterNewPassword];
    }];
}

@end
