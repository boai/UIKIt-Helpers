//
//  ErrorAlertView.h
//  photomovie
//
//  Created by Evgeny Rusanov on 06.09.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorAlertView : NSObject

+(void)showError:(NSError*)error;
+(void)showError:(NSError*)error realError:(BOOL)realError;

@end
