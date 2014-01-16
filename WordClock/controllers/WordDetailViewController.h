//
//  WordDetailViewController.h
//  WordClock
//
//  Created by ZhenzhenXu on 1/1/14.
//  Copyright (c) 2014 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordDetailViewController : UIViewController

@property (nonatomic, strong) NSString *wordStr;
@property (nonatomic, strong) IBOutlet UILabel *wordENLabel;
@property (nonatomic, strong) IBOutlet UILabel *wordZHLabel;

- (IBAction)backClicked:(id)sender;
@end
