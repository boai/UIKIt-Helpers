//
//  UITimePickView.h
//  photomovie
//
//  Created by Evgeny Rusanov on 12.09.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UITimePickView;
@protocol TimePickViewDelegate <NSObject>
-(void)timePickViewDidEnable:(UITimePickView*)timePick;
-(void)timePickViewDidDisable:(UITimePickView*)timePick;
@end

@interface UITimePickView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) NSInteger seconds;
@property (nonatomic) NSInteger minutes;
@property (nonatomic) NSInteger hours;

-(void)setInterval:(CGFloat)interval;

@property (nonatomic, weak) id<TimePickViewDelegate> delegate;

+(UITimePickView*)constructView:(id)owner;

@end
