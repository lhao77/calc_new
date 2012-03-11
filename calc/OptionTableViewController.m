//
//  OptionTableViewController.m
//  calc
//
//  Created by hao luo on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OptionTableViewController.h"

@implementation OptionTableViewController

@synthesize nsma;

-(void) setSelectIndex:(int)idx
{
    selectIndex = idx;
}

-(int)  getSelectIndex
{
    return selectIndex;
}

-(void) setParentTag:(int)idx
{
    parentTag = idx;
}
-(int)  getParentTag
{
    return parentTag;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init:(UITableViewStyle)style withItems:(NSMutableArray*)items withSelectIndex:(int)idx withParentTag:(int)itag
{
    selectIndex = idx;
    parentTag = itag;
    nsma = items;
    return [self initWithStyle:style];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [nsma count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    cell.textLabel.text = [nsma objectAtIndex:indexPath.row];
    cell.tag = indexPath.row;
    if (indexPath.row==selectIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

#import "AppDelegate.h"
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row != selectIndex)
    {
        //处理之前的选中的cell
        NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:selectIndex inSection:0];
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
        
        if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            
            oldCell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.row != selectIndex) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        selectIndex = indexPath.row;
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:[nsma objectAtIndex:selectIndex] forKey:@"value"];
        [dict setObject:indexPath forKey:@"indexPath"];
        char tmp[20];
        sprintf(tmp,"%d", [self getParentTag]);
        NSString *nstag = [NSString stringWithCString:tmp encoding:NSUTF8StringEncoding];
        [dict setObject:nstag forKey:@"parentTag"];
        NSNotification *notification = [NSNotification notificationWithName:@"OptionTableViewReturn" object:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];        
    }    
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.navigationController popViewControllerAnimated:YES];
}

@end
