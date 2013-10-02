//
//  UIOneFileDownloader.h
//  LngHDFree
//
//  Created by Evgeny Rusanov on 30.11.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HTTPrequest.h"

@interface UIOneFileDownloader : NSObject <HTTPrequestDelegate>

-(void)downloadFile:(NSString*)url completition:(void (^)(NSString*))completition;

@end
