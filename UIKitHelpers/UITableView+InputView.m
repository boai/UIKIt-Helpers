//
//  UITableView+InputView.m
//  resttimer
//
//  Created by Evgeny Rusanov on 21.03.13.
//  Copyright (c) 2013 xCoders. All rights reserved.
//

#import "UITableView+InputView.h"

#import <objc/runtime.h>

const void *INPUT_VIEW_IDENTIFER = &INPUT_VIEW_IDENTIFER;

@implementation UITableView (InputView)

-(void)removeInputView
{
    UIView *prevView = (UIView*)objc_getAssociatedObject(self, INPUT_VIEW_IDENTIFER);
    [prevView removeFromSuperview];
    objc_setAssociatedObject(self, INPUT_VIEW_IDENTIFER, nil, OBJC_ASSOCIATION_RETAIN);
}

-(void)addInputView:(UIView*)view completition:(void (^)(void))completition
{
    UIView *parent = self.superview;
    if (!parent)
    {
        NSLog(@"UITableView: Can't add input view.");
        return;
    }
    
    CGRect inputViewFrame = view.frame;
    inputViewFrame.origin.y = self.frame.size.height;
    
    CGRect newInputViewFrame = inputViewFrame;
    newInputViewFrame.origin.y = self.frame.size.height - newInputViewFrame.size.height;
    
    view.frame = inputViewFrame;
    [parent addSubview:view];
    
    CGRect tableViewFrame = self.frame;
    tableViewFrame.size.height = parent.frame.size.height - newInputViewFrame.size.height;
    
    UIView *prevView = (UIView*)objc_getAssociatedObject(self, INPUT_VIEW_IDENTIFER);
    objc_setAssociatedObject(self, INPUT_VIEW_IDENTIFER, view, OBJC_ASSOCIATION_RETAIN);
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         view.frame = newInputViewFrame;
                         self.frame = tableViewFrame;
                     } completion:^(BOOL finished) {
                         [prevView removeFromSuperview];
                         if (finished && completition)
                             completition();
                     }];
}

-(void)removeInputViewCompletition:(void (^)(void))completition
{
    UIView *parent = self.superview;
    if (!parent)
    {
        NSLog(@"UITableView: Can't add input view.");
        return;
    }
    
    UIView *view = (UIView*)objc_getAssociatedObject(self, INPUT_VIEW_IDENTIFER);
    
    CGRect tableViewFrame = self.frame;
    tableViewFrame.size.height = parent.frame.size.height;
    
    CGRect inputViewFrame = view.frame;
    inputViewFrame.origin.y = self.frame.size.height;
    [UIView animateWithDuration:0.3
                     animations:^{
                         view.frame = inputViewFrame;
                         self.frame = tableViewFrame;
                     } completion:^(BOOL finished) {
                         [view removeFromSuperview];
                         objc_setAssociatedObject(self, INPUT_VIEW_IDENTIFER, nil, OBJC_ASSOCIATION_RETAIN);
                         if (completition)
                             completition();
                     }];
}

-(void)keyboardWillShow:(CGRect)keybordFrame duration:(CGFloat)duration
{
    UIView *parent = self.superview;
    if (!parent)
        return;
    
    CGRect keybordFrameLocal = [parent convertRect:keybordFrame fromView:nil];
    
    CGRect intersectionFrame = CGRectIntersection(self.frame, keybordFrameLocal);
    
    CGRect newFrame = self.frame;
    newFrame.size.height = parent.frame.size.height - intersectionFrame.size.height;
    
    [UIView animateWithDuration:duration
                     animations:^{
                         self.frame = newFrame;
                     } completion:^(BOOL finished) {
                         if (finished)
                             [self removeInputView];
                     }];
}

-(void)keyboardWillHide:(CGRect)keybordFrame duration:(CGFloat)duration
{
    UIView *parent = self.superview;
    if (!parent)
        return;
    
    CGRect newFrame = self.frame;
    newFrame.size.height = parent.frame.size.height;
    
    [UIView animateWithDuration:duration
                     animations:^{
                         self.frame = newFrame;
                     }];
}

@end
