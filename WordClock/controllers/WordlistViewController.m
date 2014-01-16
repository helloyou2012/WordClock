//
//  WordlistViewController.m
//  WordClock
//
//  Created by ZhenzhenXu on 1/1/14.
//  Copyright (c) 2014 ZhenzhenXu. All rights reserved.
//

#import "WordlistViewController.h"
#import "WordCell.h"

@implementation WordlistViewController


@synthesize words=_words;
@synthesize selectedRowIndex=_selectedRowIndex;


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
    _tableView.backgroundColor=[UIColor clearColor];
    
    _words=[[NSMutableArray alloc] initWithObjects:@"hello", @"time", @"world", @"template",@"task", nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _selectedRowIndex=nil;
    [_tableView reloadData];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (_words.count<=0) {
        UILabel *label=[[UILabel alloc] initWithFrame:self.tableView.frame];
        label.text=@"无单词";
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:20];
        label.textAlignment=NSTextAlignmentCenter;
        self.tableView.backgroundView=label;
    }else{
        self.tableView.backgroundView=nil;
    }
    return [_words count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WordCell";
    WordCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.backgroundColor=[UIColor clearColor];
    
    cell.wordENLabel.text=[_words objectAtIndex:indexPath.row];
    cell.wordENLabel.font=[UIFont fontWithName:@"Source Code Pro" size:30];
    cell.wordENLabel.textColor=[UIColor whiteColor];
    
    cell.wordZHLabel.text=@"本站所有资源均来自互联网，版权归原作者所有，仅供研究学习使用。对资源有任何异议或资源损坏等可留言告知我们。";
    cell.wordZHLabel.font=[UIFont fontWithName:@"Source Code Pro" size:14];
    cell.wordZHLabel.textColor=[UIColor colorWithWhite:0.9 alpha:0.8];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_words removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedRowIndex&&_selectedRowIndex.row==indexPath.row) {
        _selectedRowIndex=nil;
    }else{
        self.selectedRowIndex = indexPath;
    }
    
    [tableView beginUpdates];
    [tableView endUpdates];
    if (_selectedRowIndex&&_selectedRowIndex.row==0) {
        [self performSegueWithIdentifier:@"gotoWordDetail" sender:self];
    }else{
        [tableView scrollToRowAtIndexPath:_selectedRowIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //check if the index actually exists
    if(_selectedRowIndex && indexPath.row == _selectedRowIndex.row) {
        return 516;
    }
    return 86;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (_selectedRowIndex) {
        [self performSegueWithIdentifier:@"gotoWordDetail" sender:self];
    }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [segue.destinationViewController setValue:[_words objectAtIndex:_selectedRowIndex.row] forKey:@"wordStr"];
}

- (IBAction)backClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
