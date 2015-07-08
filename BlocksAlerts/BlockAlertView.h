//
//  BlockAlertView.h
//  photomovie
//
//  Created by Evgeny Rusanov on 09.07.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BlockAlertViewStyle) {
    BlockAlertViewStyleDefault = 0,
    BlockAlertViewStyleSecureTextInput,
    BlockAlertViewStylePlainTextInput,
    BlockAlertViewStyleLoginAndPasswordInput
};

@interface BlockAlertView : NSObject 

-(instancetype)initWithTitle:(NSString*)title message:(NSString*)message;
-(instancetype)initWithTitle:(NSString*)title message:(NSString*)message style:(BlockAlertViewStyle)style;
-(void)addButton:(NSString*)title withBlock:(void (^)(BlockAlertView* alert))block;
-(void)addCancelButton:(NSString*)title withBlock:(void (^)(BlockAlertView* alert))block;

-(void)show;

-(UITextField*)textFieldAtIndex:(NSInteger)index;

@property (nonatomic, readonly) NSInteger numberOfButtons;

@property (nonatomic,copy) void (^alertDidShowBlock)(BlockAlertView *alert);
@property (nonatomic,copy) BOOL (^alertShouldDismissOnTextFieldReturnWithCompletionBlock)(BlockAlertView *alert,UITextField *textField);

@end