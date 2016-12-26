//
//  PageView.m
//  reader
//
//  Created by fairy on 16/12/23.
//  Copyright © 2016年 fairy. All rights reserved.
//

#import "PageView.h"
#import <CoreText/CoreText.h>
@implementation PageView
- (void)setText:(NSAttributedString *)attributedText
{
    self.attributedText = attributedText;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Flip the coordinate system
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTFramesetterRef childFramesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.attributedText);
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:rect];
    CTFrameRef frame = CTFramesetterCreateFrame(childFramesetter, CFRangeMake(0, 0), bezierPath.CGPath, NULL);
    CTFrameDraw(frame, context);
    CFRelease(frame);
    CFRelease(childFramesetter);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
