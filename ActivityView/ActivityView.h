//
//  ActivityView.h
//  RussianMoney
//
//  Created by Evgeny Rusanov on 27.12.11.
//  Copyright (c) 2011 Macsoftex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityView : NSObject

+(ActivityView*)sharedActivityView;

-(void)showActivityIndicator;
-(void)showActivityIndicatorWithMessage:(NSString*)msg;
-(void)hideActivityIndicator;
-(void)setMessageForActivityIndicator:(NSString*)msg;
-(void)addButton:(UIButton*)button;
-(UIButton*)addCancelButton;

@end

#define ActView [ActivityView sharedActivityView]
