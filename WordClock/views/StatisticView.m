//
//  StatisticView.m
//  WordClock
//
//  Created by ZhenzhenXu on 12/31/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "StatisticView.h"

@implementation StatisticView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGFloat borderWidth=20.0f;
        CGFloat w=CGRectGetWidth(self.bounds)-2*borderWidth;
        CGFloat h=CGRectGetHeight(self.bounds)-2*borderWidth;
        UIColor *c=[UIColor whiteColor];
        UIFont *f=[UIFont systemFontOfSize:16.0f];
        
        //labels
        CGRect successFrame = CGRectMake(borderWidth, borderWidth, w/2, 21.0f);
        UILabel *successLabel=[[UILabel alloc] initWithFrame:successFrame];
        successLabel.font=f;
        successLabel.textColor=c;
        successLabel.text=@"起床成功(次)";
        successLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:successLabel];
        
        CGRect failFrame = CGRectMake(w/2+borderWidth, borderWidth, w/2, 21.0f);
        UILabel *failLabel=[[UILabel alloc] initWithFrame:failFrame];
        failLabel.font=f;
        failLabel.textColor=c;
        failLabel.text=@"起床失败(次)";
        failLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:failLabel];
        
        CGRect rightFrame = CGRectMake(borderWidth, h/2+2*borderWidth, w/2, 21.0f);
        UILabel *rightLabel=[[UILabel alloc] initWithFrame:rightFrame];
        rightLabel.font=f;
        rightLabel.textColor=c;
        rightLabel.text=@"填对单词(个)";
        rightLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:rightLabel];
        
        CGRect wrongFrame = CGRectMake(w/2+borderWidth, h/2+2*borderWidth, w/2, 21.0f);
        UILabel *wrongLabel=[[UILabel alloc] initWithFrame:wrongFrame];
        wrongLabel.font=f;
        wrongLabel.textColor=c;
        wrongLabel.text=@"略过单词(个)";
        wrongLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:wrongLabel];
        
        //count labels
        UIFont *f_num=[UIFont fontWithName:@"Source Code Pro" size:30];
        
        CGRect successNumFrame = CGRectMake(borderWidth, 25+borderWidth, w/2, 30.0f);
        UILabel *successNumLabel=[[UILabel alloc] initWithFrame:successNumFrame];
        successNumLabel.font=f_num;
        successNumLabel.textColor=c;
        successNumLabel.text=@"3000";
        successNumLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:successNumLabel];
        
        CGRect failNumFrame = CGRectMake(w/2+borderWidth, 25+borderWidth, w/2, 30.0f);
        UILabel *failNumLabel=[[UILabel alloc] initWithFrame:failNumFrame];
        failNumLabel.font=f_num;
        failNumLabel.textColor=c;
        failNumLabel.text=@"2000";
        failNumLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:failNumLabel];
        
        CGRect rightNumFrame = CGRectMake(borderWidth, h/2+25+2*borderWidth, w/2, 30.0f);
        UILabel *rightNumLabel=[[UILabel alloc] initWithFrame:rightNumFrame];
        rightNumLabel.font=f_num;
        rightNumLabel.textColor=c;
        rightNumLabel.text=@"10000";
        rightNumLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:rightNumLabel];
        
        CGRect wrongNumFrame = CGRectMake(w/2+borderWidth, h/2+25+2*borderWidth, w/2, 30.0f);
        UILabel *wrongNumLabel=[[UILabel alloc] initWithFrame:wrongNumFrame];
        wrongNumLabel.font=f_num;
        wrongNumLabel.textColor=c;
        wrongNumLabel.text=@"30000";
        wrongNumLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:wrongNumLabel];
        
        
        self.backgroundColor=[UIColor colorWithWhite:0.2f alpha:0.2f];
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=6.0f;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    CGFloat w=CGRectGetWidth(self.bounds);
    CGFloat h=CGRectGetHeight(self.bounds);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.8f alpha:0.5f].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 1.0);
    
    CGContextMoveToPoint(context, w/2,10); //start at this point
    CGContextAddLineToPoint(context, w/2, h/2-20); //draw to this point
    
    CGContextMoveToPoint(context, w/2,h/2+20); //start at this point
    CGContextAddLineToPoint(context, w/2, h-10); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(context);
}

@end
