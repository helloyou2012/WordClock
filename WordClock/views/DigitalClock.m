//
//  DigitalClock.m
//  WordClock
//
//  Created by ZhenzhenXu on 12/31/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "DigitalClock.h"

@implementation DigitalClock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect timeFrame = CGRectMake(0,0,CGRectGetWidth(self.bounds),CGRectGetHeight(self.bounds)*5.0f/6.0f);
        _timeLabel=[[UILabel alloc] initWithFrame:timeFrame];
        _timeLabel.font=[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:100];
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        _timeLabel.textColor=[UIColor whiteColor];
        [self addSubview:_timeLabel];
        
        CGRect dateFrame = CGRectMake(0,CGRectGetHeight(self.bounds)*5.0f/6.0f,CGRectGetWidth(self.bounds),CGRectGetHeight(self.bounds)/6);
        _dateLabel=[[UILabel alloc] initWithFrame:dateFrame];
        _dateLabel.font=[UIFont systemFontOfSize:20.0f];
        _dateLabel.textAlignment=NSTextAlignmentCenter;
        _dateLabel.textColor=[UIColor whiteColor];
        [self addSubview:_dateLabel];
    }
    return self;
}

- (void)updateWith:(NSInteger)hour and:(NSInteger)minite{
    _timeLabel.text=[NSString stringWithFormat:@"%ld:%02ld",(long)hour,(long)minite];
    
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    [formater setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    //设置显示样式
    [formater setDateFormat:@"M月 d日 EEEE"];
    _dateLabel.text=[formater stringFromDate:[NSDate date]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
