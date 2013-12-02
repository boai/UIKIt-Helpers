//
//  UIActivityBarButton.m
//  photomovie
//
//  Created by Evgeny Rusanov on 02.12.13.
//  Copyright (c) 2013 Macsoftex. All rights reserved.
//

#import "UIActivityBarButton.h"

@implementation UIActivityBarButton

-(id)initWithStyle:(UIActivityIndicatorViewStyle)indicatorStyle
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:indicatorStyle];
    [indicator startAnimating];
    
    return [super initWithCustomView:indicator];
}

@end
