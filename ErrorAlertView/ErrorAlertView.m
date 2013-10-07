//
//  ErrorAlertView.m
//  photomovie
//
//  Created by Evgeny Rusanov on 06.09.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "ErrorAlertView.h"

@implementation ErrorAlertView

+(void)showError:(NSError*)error
{
    [ErrorAlertView showError:error realError:NO];
}

+(void)showError:(NSError*)error realError:(BOOL)realError
{
    if (error.code==0 && !realError)
    {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success", @"")
                                    message:error.localizedDescription
                                   delegate:nil
                          cancelButtonTitle:NSLocalizedString(@"Ok", @"")
                          otherButtonTitles:nil] show];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"")
                                    message:error.localizedDescription
                                   delegate:nil
                          cancelButtonTitle:NSLocalizedString(@"Ok", @"")
                          otherButtonTitles:nil] show];
    }
}

@end
