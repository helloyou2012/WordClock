//
//  AlarmEditViewController.m
//  WordClock
//
//  Created by ZhenzhenXu on 12/31/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "AlarmEditViewController.h"
#import "AlarmCell.h"


@implementation AlarmEditViewController

@synthesize alarms=_alarms;
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
    
    _alarms=[[NSMutableArray alloc] initWithObjects:@"12:00", @"01:00", @"13:00", @"11:00",@"12:00", @"01:00", @"13:00", @"11:00",@"12:00", @"01:00", @"13:00", @"11:00", nil];
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
    if (_alarms.count<=0) {
        UILabel *label=[[UILabel alloc] initWithFrame:self.tableView.frame];
        label.text=@"无闹钟";
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:20];
        label.textAlignment=NSTextAlignmentCenter;
        self.tableView.backgroundView=label;
    }else{
        self.tableView.backgroundView=nil;
    }
    return [_alarms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AlarmCell";
    AlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.backgroundColor=[UIColor clearColor];
    
    cell.alarmLabel.text=[_alarms objectAtIndex:indexPath.row];
    cell.alarmLabel.font=[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50];
    cell.alarmLabel.textColor=[UIColor whiteColor];
    
    cell.onOffLabel.text=@"ON";
    cell.onOffLabel.font=[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:30];
    cell.onOffLabel.textColor=[UIColor colorWithWhite:0.3 alpha:0.5];
    cell.onOffLabel.textAlignment=NSTextAlignmentRight;
    
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
        [_alarms removeObjectAtIndex:indexPath.row];
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
        [self performSegueWithIdentifier:@"gotoAlarmAdd" sender:self];
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
        [self performSegueWithIdentifier:@"gotoAlarmAdd" sender:self];
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
    [segue.destinationViewController setValue:[_alarms objectAtIndex:_selectedRowIndex.row] forKey:@"alarmStr"];
}

- (IBAction)backClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
