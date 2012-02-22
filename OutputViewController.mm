//
//  OutputViewController.m
//  calc
//
//  Created by hao luo on 12-2-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OutputViewController.h"
//#import "MMyVC.h"

@implementation OutputViewController

@synthesize m_labelControls;
@synthesize m_valueControls;
@synthesize m_cellControls;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init:(UITableViewStyle)style withTexts:(std::vector<std::string>&) txts withValues:(std::vector<std::string>&) vls withCellType:(int)type
{
    self = [self initWithStyle:style];
    texts = txts;
    values = vls;
    cell_type = type;
    
    if (!m_cellControls) {
        m_cellControls = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(CGRect) getFrame
{
    CGRect rect = [MyTableViewCell getFrame];
    rect.size.height *= texts.size();
    return rect;
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
    //self.view.frame = [self getFrame];
    //CGRect rect = self.view.frame;
    //NSLog(@"%@",self.view.frame);
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
    return texts.size();
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    // Configure the cell...
//    
//    return cell;
//}

-(NSString*) getCellValue:(int)index
{
    MyTableViewCell* cell = (MyTableViewCell*)[m_cellControls objectAtIndex:index];
    if ([cell type] == WITH_LABEL) {
        return cell.myLabel.text;
    }
    else
    {
        return cell.myTextField.text;
    }
}

-(void) setCellValue:(int)index withValue:(NSString*)value
{
    MyTableViewCell* cell = (MyTableViewCell*)[m_cellControls objectAtIndex:index];
    if ([cell type] == WITH_LABEL) {
        cell.myLabel.text = value;
    }
    else
    {
        cell.myTextField.text = value;
    }
}

- (UITableViewCell *) CreateCell:(int)type withIndex:(int) index
{
    
    UITableViewCell *cell;
    
    MyTableViewCell *mycell = [[MyTableViewCell alloc] init:type];
    //MMyVC *mycell = [[MMyVC alloc] init:type];
    NSString* text = [[NSString alloc] initWithCString:texts[index].c_str() encoding:NSUTF8StringEncoding];
    NSString* value = [[NSString alloc] initWithCString:values[index].c_str() encoding:NSUTF8StringEncoding];
    [mycell setText:text withExternalText:value];
    [mycell setIndex:index];
    [mycell.myTextField setDelegate:(id)self];
    cell = mycell.myTableViewCell;
    
    [m_cellControls insertObject:mycell atIndex:index];
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [self CreateCell:cell_type withIndex:indexPath.row];
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */    
}

-(void) setTexts:(std::vector<std::string>&)txts
{
    texts = txts;
}
-(void) setValues:(std::vector<std::string>&)vls
{
    values = vls;
}
-(std::vector<std::string>) getValues
{
    return values;
}
-(void) setCell_type:(int)type
{
    cell_type = type;
}
-(int) getCell_type
{
    return cell_type;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UITableViewCell *ui = (UITableViewCell*)[textField superview];
    NSLog(@"MyRow:%d",[self.tableView indexPathForCell:ui].row); 
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{    
    [textField resignFirstResponder];
    return YES;
}

@end
