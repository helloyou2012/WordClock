//
//  ALDClock.m
//  ALDClock
//
//  Copyright (c) 2013, Andy Drizen
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL ANDY DRIZEN BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//   LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "ALDClock.h"

#ifndef TransformRadian
#define TransformRadian(angle) (angle) *M_PI/180.0f
#endif

@interface ALDClock ()
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) UIColor *clockFaceBackgroundColor;

@end

@implementation ALDClock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [super setBackgroundColor:[UIColor clearColor]];
        
        // How wide should the clock be?
        [self updateRadius];
        
        // Set default colours
        _clockFaceBackgroundColor = [UIColor clearColor];
        _majorMarkingColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        _minorMarkingColor = [UIColor colorWithWhite:1.0 alpha:1.0];
		
        _minuteHandColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        _hourHandColor = [UIColor colorWithWhite:0.2 alpha:1.0];
		_secondHandColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        
        // Set default thicknesses
        _majorMarkingsThickness = 1.0f;
        _minorMarkingsThickness = 1.0f;
		
        _minuteHandThickness = 2.0f;
        _hourHandThickness = 2.0f;
		_secondHandThickness = 1.0f;
        
        _majorMarkingsLength = 5.0f;
        _minorMarkingsLength = 1.0f;
        
        _markingsInset = 5.0f;
        
        // Set the border properties
        _borderWidth = 2.0f;
		_borderColor = [UIColor whiteColor];
        
        // Setup the default text attributes
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        _titleAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.2 alpha:1.0],
                            NSParagraphStyleAttributeName: paragraphStyle,
                            NSFontAttributeName : [UIFont systemFontOfSize:16.0f]};
        _subtitleAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.4 alpha:1.0],
                                NSParagraphStyleAttributeName: paragraphStyle,
                                NSFontAttributeName : [UIFont systemFontOfSize:13.0f]};
        
        _digitAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithWhite:1.0 alpha:1.0],
                                NSParagraphStyleAttributeName: paragraphStyle,
                                NSFontAttributeName : [UIFont systemFontOfSize:16.0f]};
    }
    return self;
}

- (void)updateRadius
{
    _radius = MIN(CGRectGetWidth(self.frame)/2.0f, CGRectGetHeight(self.frame)/2.0f) - 20;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self updateRadius];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    [self setNeedsDisplay];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    // As we always want the background of this view to be
    // clear, we override this default method an make it
    // change the background colour of the clock instead.
    
    self.clockFaceBackgroundColor = backgroundColor;
    [self setNeedsDisplay];
}



- (void)updateWith:(NSInteger)hour and:(NSInteger)minute and:(NSInteger)seconds
{
    _secondHandAngle =seconds * 6.0f;
    _minuteHandAngle =(minute +seconds/60.0f ) *6.0f;
    _hourHandAngle = (hour%12)*30.0f + ((minute +seconds/60.0f )/60.0f)*30.0f;
    
    [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint center = CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f);
    
    // We find a max width to ensure that the clock is always
    // bounded by a square box
    
    CGFloat maxWidth = MIN(self.frame.size.width, self.frame.size.height);
    
    // Create a rect that maximises the area of the clock in the
    // square box
    
    CGRect rectForClockFace = CGRectInset(CGRectMake((self.frame.size.width - maxWidth)/2.0f,
                                                     (self.frame.size.height - maxWidth)/2.0f,
                                                     maxWidth,
                                                     maxWidth), 2*self.borderWidth, 2*self.borderWidth);
    
    // --------------------------
    // -- Draw the background  --
    // --------------------------
    
    // Draw the clock background
    CGContextSetFillColorWithColor(context, self.clockFaceBackgroundColor.CGColor);
    CGContextFillEllipseInRect(context, rectForClockFace);
    
    // --------------------------
    // --    Draw the title    --
    // --------------------------
    
    CGRect titleRect = CGRectMake(CGRectGetMinX(rectForClockFace) + CGRectGetWidth(rectForClockFace)*0.2f,
                                 CGRectGetMinY(rectForClockFace) + CGRectGetHeight(rectForClockFace)*0.25f,
                                 CGRectGetWidth(rectForClockFace)*0.6f,
                                 20.0f);
    
    [self.title drawInRect:titleRect withAttributes:self.titleAttributes];
    
    // --------------------------
    // --  Draw the subtitle   --
    // --------------------------
    
    CGRect subtitleRect = CGRectMake(CGRectGetMinX(rectForClockFace) + CGRectGetWidth(rectForClockFace)*0.2f,
                                     CGRectGetMinY(rectForClockFace) + CGRectGetHeight(rectForClockFace)*0.65f,
                                     CGRectGetWidth(rectForClockFace)*0.6f,
                                     20.0f);
    
    [self.subtitle drawInRect:subtitleRect withAttributes:self.subtitleAttributes];
    
    // --------------------------
    // --  Draw the markings   --
    // --------------------------
    
    // Set the colour of the major markings
    CGContextSetStrokeColorWithColor(context, self.majorMarkingColor.CGColor);
    // Set the major marking width
    CGContextSetLineWidth(context, self.majorMarkingsThickness);

    // Draw the major markings
    for(unsigned i = 0; i < 12; i ++)
    {
        // Get the location of the end of the hand
        CGFloat markingDistanceFromCenter = rectForClockFace.size.width/2.0f - self.markingsInset;

        CGFloat markingX1 = center.x + markingDistanceFromCenter * cos((M_PI/180)* i * 30 + M_PI);
        CGFloat markingY1 = center.y + - 1 * markingDistanceFromCenter * sin((M_PI/180)* i * 30);
        CGFloat markingX2 = center.x + (markingDistanceFromCenter - self.majorMarkingsLength) * cos((M_PI/180)* i * 30 + M_PI);
        CGFloat markingY2 = center.y + - 1 * (markingDistanceFromCenter - self.majorMarkingsLength) * sin((M_PI/180)* i * 30);
        
        // Move the cursor to the edge of the marking
        CGContextMoveToPoint(context, markingX1, markingY1);
        
        // Move to the end of the hand
        CGContextAddLineToPoint(context, markingX2, markingY2);
    }
    
    // Draw minor markings.
    CGContextDrawPath(context, kCGPathStroke);

    // Set the colour of the minor markings
    CGContextSetStrokeColorWithColor(context, self.minorMarkingColor.CGColor);
    
    // Set the minor minor width
    CGContextSetLineWidth(context, self.minorMarkingsThickness);
    
    for(NSInteger i = 0; i < 60; i ++)
    {
        // Don't put a minor mark if there's already a major mark
        if ((i % 5) == 0)
            continue;
        
        // Get the location of the end of the hand
        CGFloat markingDistanceFromCenter = rectForClockFace.size.width/2.0f -  self.markingsInset;
        
        CGFloat markingX1 = center.x + markingDistanceFromCenter * cos((M_PI/180)* i * 6 + M_PI);
        CGFloat markingY1 = center.y + - 1 * markingDistanceFromCenter * sin((M_PI/180)* i * 6);

        CGFloat markingX2 = center.x + (markingDistanceFromCenter - self.minorMarkingsLength) * cos( (M_PI/180)* i * 6+ M_PI);
        CGFloat markingY2 = center.y + - 1 * (markingDistanceFromCenter - self.minorMarkingsLength) * sin((M_PI/180)* i * 6);
        
        // Move the cursor to the edge of the marking
        CGContextMoveToPoint(context, markingX1, markingY1);
        
        // Move to the end of the hand
        CGContextAddLineToPoint(context, markingX2, markingY2);
    }
    
    // Draw minor markings.
    CGContextDrawPath(context, kCGPathStroke);
    
    // Draw the digits
    for(unsigned i = 0; i < 12; i ++)
    {
        UIFont *digitFont = self.digitAttributes[NSFontAttributeName];

        CGFloat markingDistanceFromCenter = rectForClockFace.size.width/2.0f - digitFont.lineHeight/4.0f - self.markingsInset - MAX(self.majorMarkingsLength, self.minorMarkingsLength);
        NSInteger offset = 4;
        
        CGFloat labelX = center.x + (markingDistanceFromCenter - digitFont.lineHeight/2.0f) * cos( (M_PI/180)* (i+offset) * 30 + M_PI);
        CGFloat labelY = center.y + - 1 * (markingDistanceFromCenter - digitFont.lineHeight/2.0f) * sin((M_PI/180)*(i+offset) * 30);
        
        NSString *hourNumber = [NSString stringWithFormat:@"%d", i + 1];
        [hourNumber drawInRect:CGRectMake(labelX - digitFont.lineHeight/2.0f,
                                          labelY - digitFont.lineHeight/2.0f,
                                          digitFont.lineHeight,
                                          digitFont.lineHeight)
                withAttributes:self.digitAttributes];
    }
    
    // --------------------------
    // --  Draw the hour hand  --
    // --------------------------
    
    // Set the hand width
    CGContextSetLineWidth(context, self.hourHandThickness);
    
    // Set the colour of the hand
    CGContextSetStrokeColorWithColor(context, self.hourHandColor.CGColor);
    
    // Move the cursor to the center
    CGContextMoveToPoint(context, center.x, center.y);
    
    // Get the location of the end of the hand
    CGFloat hourHandX = center.x + (0.6*self.radius) * sin(TransformRadian(_hourHandAngle));
    CGFloat hourHandY = center.y - 1 * (0.6*self.radius) * cos(TransformRadian(_hourHandAngle));
    
    // Move to the end of the hand
    CGContextAddLineToPoint(context, hourHandX, hourHandY);
    
    // Draw hour hand.
    CGContextDrawPath(context, kCGPathStroke);
    
    // --------------------------
    // -- Draw the minute hand --
    // --------------------------
    
    // Set the hand width
    CGContextSetLineWidth(context, self.minuteHandThickness);
    
    // Set the colour of the hand
    CGContextSetStrokeColorWithColor(context, self.minuteHandColor.CGColor);
    
    // Move the cursor to the center
    CGContextMoveToPoint(context, center.x, center.y );
    
    // Get the location of the end of the hand
    CGFloat minuteHandX = center.x + 0.90*self.radius * sin(TransformRadian(_minuteHandAngle));
    CGFloat minuteHandY = center.y - 1 * 0.90*self.radius * cos(TransformRadian(_minuteHandAngle));
    
    // Move to the end of the hand
    CGContextAddLineToPoint(context, minuteHandX, minuteHandY);
    
    // Draw minute hand.
    CGContextDrawPath(context, kCGPathStroke);
	
	// --------------------------
    // -- Draw the second hand --
    // --------------------------
    
    // Set the hand width
    CGContextSetLineWidth(context, self.secondHandThickness);
    
    // Set the colour of the hand
    CGContextSetStrokeColorWithColor(context, self.secondHandColor.CGColor);
    
    // Move the cursor to the center
    CGContextMoveToPoint(context, center.x, center.y );
    
    // Get the location of the end of the hand
    CGFloat secondHandX = center.x + 1.0*self.radius * sin(TransformRadian(_secondHandAngle));
    CGFloat secondHandY = center.y - 1.0*self.radius * cos(TransformRadian(_secondHandAngle));
    
    // Move to the end of the hand
    CGContextAddLineToPoint(context, secondHandX, secondHandY);
    
    // Draw minute hand.
    CGContextDrawPath(context, kCGPathStroke);
    
    // --------------------------
    // -- Draw the centre cap  --
    // --------------------------
    
    CGContextSetFillColorWithColor(context, self.minuteHandColor.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(CGRectGetMidX(rectForClockFace)-8,
                                                   CGRectGetMidY(rectForClockFace)-8,
                                                   16,
                                                   16)
                               );
    
    // --------------------------
    // --   Draw the stroke    --
    // --------------------------
    
    
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextSetLineWidth(context, 2 * self.borderWidth);
    CGContextAddEllipseInRect(context, CGRectInset(rectForClockFace, -self.borderWidth, -self.borderWidth));
    CGContextDrawPath(context, kCGPathStroke);
    
}

@end
