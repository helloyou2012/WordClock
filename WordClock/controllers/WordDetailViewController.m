//
//  WordDetailViewController.m
//  WordClock
//
//  Created by ZhenzhenXu on 1/1/14.
//  Copyright (c) 2014 ZhenzhenXu. All rights reserved.
//

#import "WordDetailViewController.h"


@implementation WordDetailViewController

@synthesize wordStr=_wordStr;

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
    
    _wordENLabel.text=_wordStr;
    _wordENLabel.font=[UIFont fontWithName:@"Source Code Pro" size:30];
    _wordENLabel.textColor=[UIColor whiteColor];
    
    _wordZHLabel.font=[UIFont fontWithName:@"Source Code Pro" size:14];
    _wordZHLabel.textColor=[UIColor colorWithWhite:0.9 alpha:0.8];
    _wordZHLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _wordZHLabel.numberOfLines=0;
    [_wordZHLabel sizeToFit];
	// Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backClicked:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
