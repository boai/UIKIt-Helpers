//
//  UITimePickerViewController.h
//  resttimer
//
//  Created by Evgeny Rusanov on 27.03.13.
//  Copyright (c) 2013 xCoders. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UITimePickerViewController;
@protocol UITimePickerDelegate <NSObject>
-(void)timePicker:(UITimePickerViewController*)picker timePicked:(double)time;
-(void)timePickerDidCancel:(UITimePickerViewController*)picker;
@end

@interface UITimePickerViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) id<UITimePickerDelegate> delegate;
@property (nonatomic) double time;

+(UIViewController*)constructTimePicker:(id<UITimePickerDelegate>)delegate
                            initialTime:(double)time;

@end
