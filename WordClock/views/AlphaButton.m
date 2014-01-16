//
//  AlphaButton.m
//  WordClock
//
//  Created by ZhenzhenXu on 12/29/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "AlphaButton.h"

@implementation AlphaButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if ([self.currentTitle length]==0) {
        CGPoint center = CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f);
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(contextRef, 1.0);
        CGContextSetStrokeColorWithColor(contextRef, [[UIColor whiteColor] CGColor]);
        CGRect circlePoint = CGRectMake(center.x-4, center.y-4, 8.0, 8.0);
        CGContextStrokeEllipseInRect(contextRef, circlePoint);
    }
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self setNeedsDisplay];
}

@end
