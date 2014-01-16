//
//  HomeViewController.m
//  WordClock
//
//  Created by ZhenzhenXu on 12/28/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "HomeViewController.h"


@implementation HomeViewController

@synthesize aldClock=_aldClock;
@synthesize digitalClock=_digitalClock;
@synthesize statisticView=_statisticView;

@synthesize scrollView=_scrollView;
@synthesize pageControl=_pageControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:92.0f/255.0f green:191.0f/255.0f blue:148.0f/255.0f alpha:1.0f];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    [self createViews];
    [self startTimer];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createViews{
    // a page is the width of the scroll view
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(320.0f*3, _scrollView.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
    
    _aldClock=[[ALDClock alloc] initWithFrame:CGRectMake(40, 20, 240, 240)];
    [_scrollView addSubview:_aldClock];
    
    _digitalClock=[[DigitalClock alloc] initWithFrame:CGRectMake(320.0f, 40, 320.0f, 150.0f)];
    [_scrollView addSubview:_digitalClock];
    
    _statisticView=[[StatisticView alloc] initWithFrame:CGRectMake(660, 40, 280, 180)];
    [_scrollView addSubview:_statisticView];
    
    [self handleTimer];
}

#pragma mark - Animation Methods

-(void)startTimer
{
	self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
												  target:self
												selector:@selector(handleTimer)
												userInfo:nil
                                                 repeats:YES];
}

- (void)handleTimer
{
    // Perform the snap, then update the hour and minute.
    NSDate *currentDate =[NSDate date];
    
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	unsigned int unitFlags = NSSecondCalendarUnit |NSMinuteCalendarUnit | NSHourCalendarUnit;
	NSDateComponents *comps = [gregorian components:unitFlags fromDate:currentDate];
    
	long seconds = [comps second];
    long minute =[comps minute];
    long hour =[comps hour];
    [_digitalClock updateWith:hour and:minute];
    [_aldClock updateWith:hour and:minute and:seconds];
}

#pragma mark - ScrollView method

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
}

- (IBAction)alarmClicked:(id)sender{
    [self performSegueWithIdentifier:@"gotoAlarm" sender:self];
}
- (IBAction)listClicked:(id)sender{
    [self performSegueWithIdentifier:@"gotoWordlist" sender:self];
}
- (IBAction)settingClicked:(id)sender{
    
}

@end
