//
//  WordlistViewController.h
//  WordClock
//
//  Created by ZhenzhenXu on 1/1/14.
//  Copyright (c) 2014 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordlistViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *words;
@property (strong, nonatomic) NSIndexPath *selectedRowIndex;

- (IBAction)backClicked:(id)sender;

@end
