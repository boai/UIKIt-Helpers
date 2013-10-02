//
//  PasswordChecker.m
//  mydiet
//
//  Created by Evgeny Rusanov on 29.12.12.
//  Copyright (c) 2012 Evgeny Rusanov. All rights reserved.
//

#import "PasswordChecker.h"

#import "BlockAlertView.h"

@implementation PasswordChecker
{
    id context;
}

-(id)init
{
    if (self = [super init])
    {
        self.title = NSLocalizedString(@"Enter password", @"");
    }
    return self;
}

-(void)enterPassword:(BOOL (^)(NSString* pass, BOOL canceled))checkerHandler
{
    context = self;
    
    BlockAlertView *alertView = [[BlockAlertView alloc] initWithTitle:self.title message:nil];
    alertView.alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [alertView addButton:NSLocalizedString(@"Cancel", @"") withBlock:^(BlockAlertView *alert) {
        checkerHandler(nil,YES);
        context = nil;
    }];
    [alertView addButton:NSLocalizedString(@"Ok", @"") withBlock:^(BlockAlertView *alert) {
        if (!checkerHandler([alert.alertView textFieldAtIndex:0].text,NO))
        {
            BlockAlertView *wrongPasswordAlert = [[BlockAlertView alloc] initWithTitle:NSLocalizedString(@"Wrong password", @"")
                                                                               message:nil];
            [wrongPasswordAlert addButton:NSLocalizedString(@"Ok", @"") withBlock:^(BlockAlertView *alert) {
                [self enterPassword:checkerHandler];
            }];
            [wrongPasswordAlert show];
        }
        else
            context = nil;
    }];
    alertView.alertView.cancelButtonIndex = 0;
    [alertView show];
}

@end
