//
//  UIOneFileDownloader.m
//  LngHDFree
//
//  Created by Evgeny Rusanov on 30.11.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "UIOneFileDownloader.h"

#import "ActivityView.h"

@implementation UIOneFileDownloader
{
    id context;
    
    void(^completitionHandler)(NSString*);
    
    HTTPrequest *_request;
}

-(void)dealloc
{
    [_request cancel];
}

-(void)endDownload:(NSString*)path
{
    [ActView hideActivityIndicator];
    
    completitionHandler(path);
    
    _request = nil;

    [UIApplication sharedApplication].idleTimerDisabled = NO;
    
    context = nil;
}

-(void)showActivityView
{
    [ActView showActivityIndicatorWithMessage:NSLocalizedString(@"Downloading...",@"")];
	UIButton *button = [ActView addCancelButton];
	[button addTarget:self
			   action:@selector(downloadCancelClick:)
	 forControlEvents:UIControlEventTouchUpInside];
}

-(void)downloadCancelClick:(id)sender
{
	[_request cancel];
	
	[self endDownload:nil];
}

-(void)downloadFile:(NSString*)url completition:(void (^)(NSString*))completition
{
    completitionHandler = [completition copy];
    
    context = self;
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    [self showActivityView];
	
	_request = [[HTTPrequest alloc] init];
    _request.downloadToFile = YES;
	_request.delegate = self;
	[_request sendRequest:url];
}

#pragma mark - 

-(void)httpRequest:(HTTPrequest*)request error:(NSError*)errorCode
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:NSLocalizedString(@"Error downloading",@"")
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Ok",@"")
                                          otherButtonTitles:nil];
    [alert show];
    
    [self endDownload:nil];
}

-(void)httpRequest:(HTTPrequest *)request dataFileLoaded:(NSString *)path
{
    [self endDownload:path];
}

-(void)httpRequest:(HTTPrequest*)request dataPortionAdded:(NSMutableData*)data
{
    if (request.expectedContentLength>0)
    {
        CGFloat percent = (100.0 * (CGFloat)request.downloadedBytes) / (CGFloat)request.expectedContentLength;
        [ActView setMessageForActivityIndicator:
         [NSString stringWithFormat:NSLocalizedString(@"Downloading: %d%%",@""),(int)percent]];
    }
}

@end
