//
//  ActivityView.m
//  RussianMoney
//
//  Created by Evgeny Rusanov on 27.12.11.
//  Copyright (c) 2011 Macsoftex. All rights reserved.
//

#import "ActivityView.h"

#import <QuartzCore/QuartzCore.h>

@implementation ActivityView
{
    UIView *activityView;
    
    UIView *centerView;
}

#define ACTIVITY_MSG 1001

+(ActivityView*)sharedActivityView
{
    static ActivityView *inst = nil;
    if (!inst)
        inst = [[ActivityView alloc] init];
    return inst;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChange:)
                                                     name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    }
    
    return self;
}

- (CGAffineTransform)transformForOrientation {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"UIDeviceOrientationDidChangeNotification" object:nil];
}

- (void)deviceOrientationDidChange:(void*)object {
    if (!activityView) return;
    
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    centerView.transform = [self transformForOrientation];
    [UIView commitAnimations];
}

-(void)showActivityIndicator
{
	if (activityView) return;
	
	UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (!window)
        window = [[[UIApplication sharedApplication] windows] lastObject];
	UIView *view = window;
    
    centerView = [[UIView alloc] initWithFrame:CGRectMake((view.bounds.size.width - 320)*0.5, (view.bounds.size.height - 320)*0.5, 320, 320)];
    centerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin  |
                                    UIViewAutoresizingFlexibleRightMargin |
                                    UIViewAutoresizingFlexibleTopMargin   |
                                    UIViewAutoresizingFlexibleBottomMargin;
    centerView.transform = [self transformForOrientation];
        
	activityView = [[UIView alloc] initWithFrame: view.bounds];
	activityView.backgroundColor = [UIColor blackColor];
	activityView.alpha = 0.75;
	
	activityView.autoresizingMask =	UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	UIActivityIndicatorView *activityWheel = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(centerView.bounds.size.width / 2 - 12, 
																										centerView.bounds.size.height / 2 - 12, 
																										24, 
																										24)];
	activityWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	activityWheel.autoresizingMask = UIViewAnimationTransitionNone;
	
	activityWheel.layer.opacity = 1.0;
    
    [activityView addSubview:centerView];
	
	[centerView addSubview:activityWheel];
	[view addSubview: activityView];	
	[[[centerView subviews] objectAtIndex:0] startAnimating];
}

-(void)showActivityIndicatorWithMessage:(NSString*)msg
{ 
	[self showActivityIndicator];
    CGRect activityWeelRect = [[[centerView subviews] objectAtIndex:0] frame];
	CGRect r = CGRectMake(0, activityWeelRect.origin.y+24, centerView.bounds.size.width, 15*3);
	UILabel *label = [[UILabel alloc] initWithFrame:r];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.text = msg;
	label.textAlignment = NSTextAlignmentCenter;
	label.autoresizingMask = UIViewAutoresizingNone;
	label.tag = ACTIVITY_MSG;
    
	
	if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
	{
		label.font = [UIFont systemFontOfSize:12];
	}
    else
    {
        label.font = [UIFont systemFontOfSize:14];
    }
	
	label.layer.opacity = 1.0;
	label.numberOfLines = 3;
	
	[centerView addSubview:label];
}

-(void)hideActivityIndicator
{
	if (activityView == nil) return;
	
	[[[centerView subviews] objectAtIndex:0] stopAnimating];
	[activityView removeFromSuperview];
	activityView = nil;
}

-(void)setMessageForActivityIndicator:(NSString*)msg
{
	if (activityView==nil)
		return;
	
	if ([centerView viewWithTag:ACTIVITY_MSG]==nil)
	{
        [self showActivityIndicatorWithMessage:msg];
	}
	
	UILabel *label = (UILabel*)[centerView viewWithTag:ACTIVITY_MSG];
	label.text = msg;
}

-(void)addButton:(UIButton*)button
{
	if (activityView)
	{
		UILabel *label = (UILabel*)[centerView viewWithTag:ACTIVITY_MSG];
		CGFloat y = 0;
		if (label)
			y = label.frame.origin.y+label.frame.size.height+10;
		else
		{
			CGFloat offset = centerView.bounds.size.height*0.5;
			y = offset+(offset-button.frame.size.height)*0.5;
		}
        
		CGFloat x = (centerView.bounds.size.width-button.frame.size.width)*0.5;
		CGRect r = button.frame;
		r.origin = CGPointMake(x, y);
		button.frame = r;
		button.autoresizingMask = UIViewAutoresizingNone;
		[centerView addSubview:button];
	}
}

-(UIButton*)addCancelButton
{
    UIImage *buttonImage = [UIImage imageNamed:@"br280x50.png"];
    buttonImage = [buttonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 190, 50);
    [button setTitle:NSLocalizedString(@"Cancel",@"") forState:UIControlStateNormal];
    [button setTitle:NSLocalizedString(@"Cancel",@"") forState:UIControlStateHighlighted];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImage forState:UIControlStateHighlighted];
    [self addButton:button];
    
    return button;
}

@end
