//
//  HomeViewController.h
//  WordClock
//
//  Created by ZhenzhenXu on 12/28/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDClock.h"
#import "DigitalClock.h"
#import "StatisticView.h"

@interface HomeViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) ALDClock *aldClock;
@property (nonatomic, strong) DigitalClock *digitalClock;
@property (nonatomic, strong) StatisticView *statisticView;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;


- (IBAction)alarmClicked:(id)sender;
- (IBAction)listClicked:(id)sender;
- (IBAction)settingClicked:(id)sender;

@end
