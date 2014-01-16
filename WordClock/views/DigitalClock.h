//
//  DigitalClock.h
//  WordClock
//
//  Created by ZhenzhenXu on 12/31/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DigitalClock : UIView

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *dateLabel;

- (void)updateWith:(NSInteger)hour and:(NSInteger)minite;

@end
