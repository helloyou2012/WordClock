//
//  AlarmEditViewController.h
//  WordClock
//
//  Created by ZhenzhenXu on 12/31/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmEditViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *alarms;
@property (strong, nonatomic) NSIndexPath *selectedRowIndex;

- (IBAction)backClicked:(id)sender;

@end
