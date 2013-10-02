//
//  BlockAlertView.h
//  photomovie
//
//  Created by Evgeny Rusanov on 09.07.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockAlertView : NSObject <UIAlertViewDelegate>

@property (nonatomic, strong, readonly) UIAlertView *alertView;

-(id)initWithTitle:(NSString*)title message:(NSString*)message;
-(void)addButton:(NSString*)title withBlock:(void (^)(BlockAlertView* alert))block;

-(void)show;

@end