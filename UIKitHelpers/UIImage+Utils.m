//
//  UIImage+Utils.m
//  photomovie
//
//  Created by Evgeny Rusanov on 21.07.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "UIImage+Utils.h"

#import "FileSystem.h"

@implementation UIImage (Utils)

-(void)saveToFileJPG:(NSString*)path
{
    NSData *data = UIImageJPEGRepresentation(self, 0.7);
    [data writeToFile:path atomically:YES];
}

-(NSString*)saveToFolder:(NSString*)folder
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",folder,[FileSystem randomFileName:@"JPG"]];
    [self saveToFileJPG:filePath];
    return filePath;
}

-(UIImage*)makeThumbnail:(CGSize)size
{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = size.width;
    CGFloat scaledHeight = size.height;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, size) == NO)
    {
        CGFloat widthFactor = size.width / imageSize.width;
        CGFloat heightFactor = size.width / imageSize.height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth  = imageSize.width * scaleFactor;
        scaledHeight = imageSize.height * scaleFactor;
        
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (size.height - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (size.height - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    UIGraphicsEndImageContext();
    return newImage;
}

@end
