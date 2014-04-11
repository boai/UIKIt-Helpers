//
//  UIViewController+Helpers.h
//  photomovie
//
//  Created by Evgeny Rusanov on 06.09.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Helpers)

-(UIViewController*)findTopViewController;

-(UIBarButtonItem*)customBarButtonItemWithImageName:(NSString*)imageName action:(SEL)selector;

@end
