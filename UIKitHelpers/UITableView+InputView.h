//
//  UITableView+InputView.h
//  resttimer
//
//  Created by Evgeny Rusanov on 21.03.13.
//  Copyright (c) 2013 xCoders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (InputView)

-(void)addInputView:(UIView*)view completition:(void (^)(void))completition;
-(void)removeInputViewCompletition:(void (^)(void))completition;

-(void)keyboardWillShow:(CGRect)keybordFrame duration:(float)duration;
-(void)keyboardWillHide:(CGRect)keybordFrame duration:(float)duration;

@end
