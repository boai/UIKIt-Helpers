//
//  UICloseButton.m
//  LngHDFree
//
//  Created by Evgeny Rusanov on 18.06.12.
//  Copyright (c) 2012 Macsoftex. All rights reserved.
//

#import "UICloseButton.h"

@implementation UICloseButton

- (void)drawRect:(CGRect)rect {
	CGFloat radius = MIN(rect.size.width, rect.size.height)/2;
	CGFloat hWidth = CGRectGetMidX(rect);
	CGFloat hHeight = CGRectGetMidY(rect);
	CGFloat outerLineWidth = 1.0f;
	CGFloat x = radius*0.35;
	
	CGContextRef c = UIGraphicsGetCurrentContext();
	
	CGColorRef whiteColor = [(self.highlighted ? [UIColor lightGrayColor] : [UIColor whiteColor]) CGColor];
	CGColorRef blackColor = [[UIColor blackColor] CGColor];
	
	CGContextSetFillColorWithColor(c, whiteColor);
	CGContextSetStrokeColorWithColor(c, blackColor);
	CGContextSetLineWidth(c, outerLineWidth);
	CGContextMoveToPoint(c, hWidth + radius - outerLineWidth, hHeight);
	CGContextAddArc(c, hWidth, hHeight, radius - outerLineWidth, 0, 2*M_PI, false);
	CGContextDrawPath(c, kCGPathFillStroke);
	
	CGContextSetFillColorWithColor(c, blackColor);
	CGContextMoveToPoint(c, hWidth + (radius*0.75), hHeight);
	CGContextAddArc(c, hWidth, hHeight, radius*0.75, 0, 2*M_PI, false);
	CGContextDrawPath(c, kCGPathFill);
	
	CGContextSetStrokeColorWithColor(c, whiteColor);
	CGContextSetLineWidth(c, radius*0.2);
	CGContextMoveToPoint	(c, hWidth-x, hHeight-x); // x.
	CGContextAddLineToPoint	(c, hWidth+x, hHeight+x); // .x
	CGContextMoveToPoint	(c, hWidth+x, hHeight-x); // .x
	CGContextAddLineToPoint	(c, hWidth-x, hHeight+x); // x.	
	CGContextDrawPath(c, kCGPathStroke);
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	[self setNeedsDisplay];
}

@end
