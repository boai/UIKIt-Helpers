//
//  PasswordChecker.h
//  mydiet
//
//  Created by Evgeny Rusanov on 29.12.12.
//  Copyright (c) 2012 Evgeny Rusanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PasswordChecker : NSObject

@property (nonatomic, strong) NSString *title;

-(void)enterPassword:(BOOL (^)(NSString* pass, BOOL canceled))checkerHandler;

@end
