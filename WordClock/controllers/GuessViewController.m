//
//  GuessViewController.m
//  WordClock
//
//  Created by ZhenzhenXu on 12/27/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "GuessViewController.h"
#import "CoreDataEnvir.h"
#import "AlphaButton.h"


@implementation GuessViewController

@synthesize wordButtons=_wordButtons;
@synthesize currentWord=_currentWord;

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
    
    [self createWords];
    [self createKeyboard];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)createWords{
    NSInteger word_count=[[Word items] count];
    NSInteger randomNumber = arc4random() % word_count;
    _currentWord=[[Word items] objectAtIndex:randomNumber];
    
    //init text and label views
    _wordZhText.text=_currentWord.word_zh;
    _wordZhText.alpha=0.0f;
    
    NSArray *prons=[_currentWord.word_pron componentsSeparatedByString:@","];
    NSString *pron_str=[prons objectAtIndex:0];
    if (pron_str.length<3&&prons.count>1) {
        pron_str=[NSString stringWithFormat:@"[%@", [prons objectAtIndex:1]];
    }
    if ([pron_str rangeOfString:@"]"].location==NSNotFound){
        pron_str=[pron_str stringByAppendingString:@"]"];
    }
    _pronLabel.text=pron_str;
    _pronLabel.font=[UIFont fontWithName:@"Source Code Pro" size:26];
    _pronLabel.alpha=0.0f;
    
    //init alpha buttons
    if (!_wordButtons) {
        _wordButtons=[[NSMutableArray alloc] init];
    }
    
    CGFloat X_offset=160.0f-25.0f/2*_currentWord.word_en.length;
    CGFloat Y_offset=self.view.frame.size.height-252.0f;
    
    for (int i=0; i<_currentWord.word_en.length; i++) {
        CGRect rect=CGRectMake(X_offset+i*25.0f, Y_offset, 26, 40);
        AlphaButton *button=[[AlphaButton alloc] initWithFrame:rect];
        button.showsTouchWhenHighlighted=YES;
        button.titleLabel.font=[UIFont fontWithName:@"Source Code Pro" size:35];
        [button addTarget:self action:@selector(clearAlphaClick:) forControlEvents:UIControlEventTouchUpInside];
        button.alpha=0.0f;
        [_wordButtons addObject:button];
        [self.view addSubview:button];
    }
    
    [UIView animateWithDuration:0.8 animations:^{
        for (AlphaButton *button in _wordButtons) {
            button.alpha = 1.0;
        }
        _wordZhText.alpha=1.0f;
        _pronLabel.alpha=1.0f;
    }completion:^(BOOL finished){
        NSString *match_path = [[NSBundle mainBundle] pathForResource:@"shake_match" ofType:@"wav"];
        NSData *matchData = [NSData dataWithContentsOfFile:match_path];
        _player=[[AVAudioPlayer alloc] initWithData:matchData error:nil];
        _player.delegate=self;
        [_player play];
    }];
}

- (void)createKeyboard{
    CGFloat X_offset=6.0f;
    CGFloat Y_offset=self.view.frame.size.height-182.0f;
    
    NSArray *alpha=@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",
                     @"H",@"I",@"J",@"K",@"L",@"M",@"N",
                     @"O",@"P",@"Q",@"R",@"S",@"T",@"U",
                     @"V",@"W",@"X",@"Y",@"Z"];
    for (int i=0; i<alpha.count; i++) {
        int row=i/7;
        int col=i%7;
        CGRect alphaRect=CGRectMake(X_offset+col*44.0f+2, Y_offset+row*44.0f+2, 40.0f, 40.0f);
        UIButton *button=[[UIButton alloc] initWithFrame:alphaRect];
        [button setTitle:[alpha objectAtIndex:i] forState:UIControlStateNormal];
        button.showsTouchWhenHighlighted=YES;
        // 设置圆角半径
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 2;
        //还可设置边框宽度和颜色
        button.layer.backgroundColor=[UIColor colorWithWhite:0.5f alpha:1.0f].CGColor;
        [button addTarget:self action:@selector(alphaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    CGRect alphaRect=CGRectMake(X_offset+5*44.0f+2, Y_offset+3*44.0f+2, 84.0f, 40.0f);
    UIButton *button=[[UIButton alloc] initWithFrame:alphaRect];
    [button setTitle:@"Clear" forState:UIControlStateNormal];
    button.showsTouchWhenHighlighted=YES;
    // 设置圆角半径
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 2;
    //还可设置边框宽度和颜色
    button.layer.backgroundColor=[UIColor colorWithWhite:0.5f alpha:1.0f].CGColor;
    [button addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alphaButtonClick:(id)sender{
    NSString *alpha=[(UIButton*)sender currentTitle];
    
    for (UIButton *btn in _wordButtons) {
        if ([btn.currentTitle length]==0) {
            [btn setTitle:[alpha lowercaseString] forState:UIControlStateNormal];
            break;
        }
    }
}

- (void)clearButtonClick:(id)sender{
    for (UIButton *btn in _wordButtons) {
        [btn setTitle:@"" forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor clearColor];
    }
}

- (void)clearAlphaClick:(id)sender{
    UIButton *btn=(UIButton*)sender;
    [btn setTitle:@"" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor clearColor];
}

- (IBAction)gotoHomeClicked:(id)sender{
    [self performSegueWithIdentifier:@"gotoHome" sender:self];
    /*
    NSString *urlAsString=[NSString stringWithFormat:@"http://dict.helloyou2012.me/static/audios/%@.mp3",_currentWord.id];
    NSURL *url=[NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length]>0&&error==nil) {
            _player=[[AVAudioPlayer alloc] initWithData:data error:nil];
            _player.delegate=self;
            [_player play];
        }
        else if([data length]==0&&error==nil) {
            NSLog(@"Nothing");
        }
        else if(error!=nil) {
            NSLog(@"Error:%@",error);
        }
    }];*/
}

#pragma motion shake

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSString *shake_path = [[NSBundle mainBundle] pathForResource:@"shake_sound" ofType:@"wav"];
    NSData *shakeData = [NSData dataWithContentsOfFile:shake_path];
    _player=[[AVAudioPlayer alloc] initWithData:shakeData error:nil];
    _player.delegate=self;
    [_player play];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
	if (motion == UIEventSubtypeMotionShake )
	{
        for (UIButton *btn in _wordButtons) {
            [UIView animateWithDuration:0.3 animations:^{
                btn.alpha = 0.0;
            }completion:^(BOOL finished){
                [btn removeFromSuperview];
                [btn removeTarget:self action:@selector(clearAlphaClick:) forControlEvents:UIControlEventTouchUpInside];
            }];
            
        }
        [_wordButtons removeAllObjects];
        _currentWord.fail_num=[NSNumber numberWithInt:_currentWord.fail_num.intValue+1];
        [_currentWord save];
        [self createWords];
	}
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //AudioServicesPlaySystemSound (_shakeNomatchID);
}

@end
