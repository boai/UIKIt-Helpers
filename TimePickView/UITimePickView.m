//
//  UITimePickView.m
//  photomovie
//
//  Created by Evgeny Rusanov on 12.09.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "UITimePickView.h"

@implementation UITimePickView
{
    __weak IBOutlet UIPickerView *picker;
}

+(UITimePickView*)constructView:(id)owner
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TimePickView" owner:owner options:nil];
    return [nib objectAtIndex:0];
}

- (IBAction)disableClick:(id)sender {
    [self.delegate timePickViewDidDisable:self];
}
- (IBAction)setClick:(id)sender {
    [self.delegate timePickViewDidEnable:self];
}

-(void)setHours:(int)hours
{
    _hours = hours;
    [picker selectRow:self.hours inComponent:0 animated:NO];
}

-(void)setMinutes:(int)minutes
{
    _minutes = minutes;
    [picker selectRow:self.minutes inComponent:1 animated:NO];
}

-(void)setSeconds:(int)seconds
{
    _seconds = seconds;
    [picker selectRow:self.seconds inComponent:2 animated:NO];
}

-(void)setInterval:(float)interval
{
    int hours = (int)floor(interval / 3600.0);
    interval-=(hours*3600);
    
    int minutes = (int)floor(interval / 60.0);
    interval-=(minutes*60);
    
    self.hours = hours;
    self.minutes = minutes;
    self.seconds = interval;
}

#pragma mark - 

-(int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 61;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d",row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0)
        _hours = row;
    else if (component==1)
        _minutes = row;
    else if (component==2)
        _seconds = row;
}

@end
