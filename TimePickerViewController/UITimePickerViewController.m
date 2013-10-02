//
//  UITimePickerViewController.m
//  resttimer
//
//  Created by Evgeny Rusanov on 27.03.13.
//  Copyright (c) 2013 xCoders. All rights reserved.
//

#import "UITimePickerViewController.h"

#import "TimeHelper.h"

@implementation UITimePickerViewController
{
    __weak IBOutlet UITextField *timeTextField;
    __weak IBOutlet UIDatePicker *timePicker;
    
}

+(UIViewController*)constructTimePicker:(id<UITimePickerDelegate>)delegate
                            initialTime:(double)time
{
    UITimePickerViewController *controller = [[UITimePickerViewController alloc] initWithNibName:@"UITimePickerViewController" bundle:nil];
    controller.delegate = delegate;
    controller.time = time;
    
    return [[UINavigationController alloc] initWithRootViewController:controller];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

- (IBAction)timeChanged:(id)sender {
    [self updateTime:sender];
}

-(void)updateTime:(UIDatePicker*)pickerView
{
    self.time = pickerView.countDownDuration;
    
    TimeHelper *th = [[TimeHelper alloc] initWithSeconds:self.time];
    timeTextField.text = [th convertToString_HHmm];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    timePicker.countDownDuration = self.time;
    
    [self updateTime:timePicker];
    self.title = NSLocalizedString(@"Pick Time", @"Time picker title");
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancelClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(doneClick)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

-(void)doneClick
{
    if (self.delegate)
        [self.delegate timePicker:self timePicked:self.time];
}

-(void)cancelClick
{
    if (self.delegate)
        [self.delegate timePickerDidCancel:self];
}

@end
