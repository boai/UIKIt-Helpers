//
//  UIImage+Utils.h
//  photomovie
//
//  Created by Evgeny Rusanov on 21.07.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

-(void)saveToFileJPG:(NSString*)path;
-(NSString*)saveToFolder:(NSString*)folder;
-(UIImage*)makeThumbnail:(CGSize)size;

@end
