//
//  AddAlarmViewController.h
//  WordClock
//
//  Created by ZhenzhenXu on 1/1/14.
//  Copyright (c) 2014 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAlarmViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *alarmLabel;
@property (nonatomic, strong) IBOutlet UIButton *onOffButton;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) IBOutlet UIButton *okButton;

@property (nonatomic, strong) NSString *alarmStr;

- (IBAction)backClicked:(id)sender;
- (IBAction)onOffClicked:(id)sender;
- (IBAction)datePickerChanged:(id)sender;

@end
