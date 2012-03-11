//
//  TestTableViewController.m
//  calc
//
//  Created by hao luo on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestTableViewController.h"


@implementation TestTableViewController

@synthesize items;

-(NSMutableDictionary*)createOneByIndex:(int) i
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    char tmp[20];
    sprintf(tmp, "%d",i);
    [dict setObject:[NSString stringWithCString:tmp] forKey:@"tag"];
    
    int j = i%3==0?1:2;
    sprintf(tmp, "%d",j);
    [dict setObject:[NSString stringWithCString:tmp] forKey:@"type"];
    sprintf(tmp,"i am %d",i);
    [dict setObject:[NSString stringWithCString:tmp] forKey:@"title"];
    
    return dict;
}

- (void)initData
{
    items = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        NSMutableDictionary *dict = [self createOneByIndex:i];
        
        [items addObject:dict];
    }
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self initData];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//add or remove cell    注意先后顺序的不同
- (void) updateCell
{
    [items removeObjectAtIndex:5];
    //[items addObject: [self createOneByIndex:16]];
    [items insertObject:[self createOneByIndex:11] atIndex:5];
    [items insertObject:[self createOneByIndex:16] atIndex:8];
    //[items removeObjectAtIndex:5];

    
    NSArray *delIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:5 inSection:0],nil];
    NSArray *insertIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:5 inSection:0],[NSIndexPath indexPathForRow:8 inSection:0],nil];
    UITableView *tv = (UITableView*)self.view;
    [tv beginUpdates];
    [tv insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationRight];
[tv deleteRowsAtIndexPaths:delIndexPaths withRowAnimation:UITableViewRowAnimationRight];
        [tv endUpdates];
    
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
    static int i =0;
    if (i==1) {
        [self updateCell];
    }
    i++;
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
    return [items count];
}

#import "EqInstalmentViewController.h"
extern EqInstalmentViewController *g_EqInstalmentViewController;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSMutableDictionary *md = [items objectAtIndex:indexPath.row];    
    cell.tag = atoi([[md objectForKey:@"tag"] UTF8String]);
    [cell setText:[md objectForKey:@"title"]];
    
    if (indexPath.row%3==0) {
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        //cell.accessoryView = g_EqInstalmentViewController.view;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    //[self.navigationController pushViewController:g_EqInstalmentViewController animated:YES];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.navigationController pushViewController:g_EqInstalmentViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //g_EqInstalmentViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    //[self presentModalViewController:g_EqInstalmentViewController animated:YES];
    //[self.navigationController pushViewController:g_EqInstalmentViewController animated:YES];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.navigationController pushViewController:g_EqInstalmentViewController animated:YES];
}

@end
