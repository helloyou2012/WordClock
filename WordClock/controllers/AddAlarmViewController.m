//
//  AddAlarmViewController.m
//  WordClock
//
//  Created by ZhenzhenXu on 1/1/14.
//  Copyright (c) 2014 ZhenzhenXu. All rights reserved.
//

#import "AddAlarmViewController.h"


@implementation AddAlarmViewController

@synthesize alarmLabel=_alarmLabel;
@synthesize onOffButton=_onOffButton;
@synthesize datePicker=_datePicker;
@synthesize cancelButton=_cancelButton;
@synthesize okButton=_okButton;
@synthesize alarmStr=_alarmStr;

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
}

- (void)createViews{
    _alarmLabel.text=_alarmStr;
    _alarmLabel.font=[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50];
    _alarmLabel.textColor=[UIColor whiteColor];
    
    
    [_onOffButton setTitle:@"OFF" forState:UIControlStateNormal];
    [_onOffButton setTitle:@"ON" forState:UIControlStateSelected];
    [_onOffButton setTitleColor:[UIColor colorWithWhite:0.3 alpha:0.5] forState:UIControlStateNormal];
    [_onOffButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:1.0] forState:UIControlStateSelected];
    _onOffButton.tintColor=[UIColor clearColor];
    _onOffButton.showsTouchWhenHighlighted = YES;
    _onOffButton.titleLabel.font=[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:30];
    _onOffButton.titleLabel.textAlignment=NSTextAlignmentRight;
    
    _cancelButton.layer.masksToBounds=YES;
    _cancelButton.layer.cornerRadius=4.0f;
    _cancelButton.layer.borderColor=[UIColor colorWithWhite:0.9 alpha:0.8].CGColor;
    _cancelButton.layer.borderWidth=1.0f;
    _cancelButton.alpha=0.0f;
    
    _okButton.layer.masksToBounds=YES;
    _okButton.layer.cornerRadius=4.0f;
    _okButton.layer.borderColor=[UIColor colorWithWhite:0.9 alpha:0.8].CGColor;
    _okButton.layer.borderWidth=1.0f;
    _okButton.backgroundColor=[UIColor colorWithWhite:0.9 alpha:0.3];
    _okButton.alpha=0.0f;
    
    _datePicker.alpha=0.0f;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.8 animations:^{
        _datePicker.alpha=1.0f;
        _okButton.alpha=1.0f;
        _cancelButton.alpha=1.0f;
    }completion:^(BOOL finished){
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"HH:mm"];
        NSDate *myDate = [df dateFromString: _alarmStr];
        [_datePicker setDate:myDate animated:YES];
    }];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onOffClicked:(id)sender{
    if ([_onOffButton isSelected]) {
        [_onOffButton setSelected:NO];
    }else{
        [_onOffButton setSelected:YES];
    }
}

- (IBAction)datePickerChanged:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    _alarmStr=[df stringFromDate:[_datePicker date]];
    _alarmLabel.text=_alarmStr;
}

- (IBAction)backClicked:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
