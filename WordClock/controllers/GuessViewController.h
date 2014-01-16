//
//  GuessViewController.h
//  WordClock
//
//  Created by ZhenzhenXu on 12/27/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Word.h"

@interface GuessViewController : UIViewController <AVAudioPlayerDelegate>

@property (nonatomic, strong) NSMutableArray *wordButtons;
@property (nonatomic, strong) Word *currentWord;
@property (strong, nonatomic) IBOutlet UITextView *wordZhText;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UILabel *pronLabel;
@property (nonatomic, strong) AVAudioPlayer *player;

- (void)alphaButtonClick:(id)sender;
- (void)clearButtonClick:(id)sender;

- (IBAction)gotoHomeClicked:(id)sender;

@end
