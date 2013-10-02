//
//  PasswordChanger.h
//  mydiet
//
//  Created by Evgeny Rusanov on 29.12.12.
//  Copyright (c) 2012 Evgeny Rusanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PasswordChanger : NSObject

@property (nonatomic) BOOL hasOldPassword;

-(void)changePassword:(BOOL (^)(NSString* pass))oldPassCheck complete:(void (^)(NSString *newPassword, BOOL canceled))complete;

@end
