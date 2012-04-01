//
//  PrepaymentViewController.m
//  calc
//
//  Created by hao luo on 12-3-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PrepaymentViewController.h"
#import "AppDelegate.h"
#include "StringMgr.h"

extern NSString* CELL_LEFT_TITLE;
extern NSString* CELL_RIGHT_VALUE;
extern NSString* CELL_RIGHT_UTIL;
extern NSString* CELL_RIGHT_CONTROLTYPE;
extern NSString* CELL_ACCESSORYTYPE;
extern NSString* CELL_TAG;

extern UITableViewCellAccessoryType getTableViewCellAccessoryType(NSString* str);
extern int getControllerType(NSString* str);

@implementation PrepaymentViewController

@synthesize items;
@synthesize pre_payment_type;
@synthesize pre_payment_reduce_type;
@synthesize pre_types;
@synthesize pre_reduce_types;
@synthesize cells;
@synthesize result_pre_payment;
/*
 items结构是字典的组合:
 "title","..."
 "rvalue","..."
 "rutil","..."
 "rcontroltype","..."
 "accessorytype","..."
 "tag","..."
*/

- (id) init:(NSMutableArray*)nsma withPreTypes:(NSMutableArray*)pts withPreReduceTypes:(NSMutableArray*)prts withStyle:(UITableViewStyle)style
{
    self = [self initWithStyle:style];
    self.items = nsma;
    self.pre_types = pts;
    self.pre_reduce_types = prts;
    
    self.pre_payment_type = [[OptionTableViewController alloc] init:UITableViewStylePlain withItems:pre_types withSelectIndex:0 withParentTag:4];
    self.pre_payment_reduce_type = [[OptionTableViewController alloc] init:UITableViewStylePlain withItems:pre_reduce_types withSelectIndex:0 withParentTag:6];
    
    [self initCells];
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (MyTableViewCell*)creatCellAtIndex:(int)idx
{
    MyTableViewCell *mycell = [[MyTableViewCell alloc] init:getControllerType((NSString*)[(NSMutableDictionary*)[self.items objectAtIndex:idx] objectForKey: CELL_RIGHT_CONTROLTYPE]) accessoryType:getTableViewCellAccessoryType((NSString*)[(NSMutableDictionary*)[self.items objectAtIndex:idx] objectForKey: CELL_ACCESSORYTYPE])];
    [mycell setText:(NSString*)[(NSMutableDictionary*)[self.items objectAtIndex:idx] objectForKey: CELL_LEFT_TITLE] withExternalText:(NSString*)[(NSMutableDictionary*)[self.items objectAtIndex:idx] objectForKey: CELL_RIGHT_VALUE]];
    mycell.myTextField.delegate = self;
    [cells insertObject:mycell atIndex:idx];
    return mycell;
}
- (void)initCells
{
    cells = [[NSMutableArray alloc] init];
    for (int i=0; i<[items count]; i++) {
        [self creatCellAtIndex:i]; 
    }
}

- (UITableViewCell*) createCell:(NSString*)LeftTitle withRightValue:(NSString*)value withRightControlType:(int)type withAccessoryType:(UITableViewCellAccessoryType)type
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lh"];
    cell.accessoryType = type;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) handleOptionTableViewReturn:(NSNotification *)notification
{
    NSMutableDictionary *dict = [notification object];
    NSLog(@"dict=%@\n",dict);
    NSString *parentTag = (NSString*)[dict objectForKey:@"parentTag"];
    if ([parentTag isEqual:@"4"]) {
        MyTableViewCell *sele = [cells objectAtIndex:4];
        [sele setExternalText:[dict objectForKey:@"value"]];
        NSIndexPath *idx = [dict objectForKey:@"indexPath"];
        if (idx.row==1) {//一次付清
            [cells removeObjectAtIndex:6];
            [cells removeObjectAtIndex:5];
            NSArray *delIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:6 inSection:0],[NSIndexPath indexPathForRow:5 inSection:0],nil];
            UITableView *tv = (UITableView*)self.view;
            [tv beginUpdates];
            [tv deleteRowsAtIndexPaths:delIndexPaths withRowAnimation:UITableViewRowAnimationRight];
            [tv endUpdates];
        }
        else
        {
            if ([cells count]==5) {
                [self creatCellAtIndex:5];
                [self creatCellAtIndex:6];
                NSArray *delIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:5 inSection:0],[NSIndexPath indexPathForRow:6 inSection:0],nil];
                UITableView *tv = (UITableView*)self.view;
                [tv beginUpdates];
                [tv insertRowsAtIndexPaths:delIndexPaths withRowAnimation:UITableViewRowAnimationRight];
                [tv endUpdates];
            }
        }
    }
    else if([parentTag isEqual:@"6"]) 
    {
        MyTableViewCell *sele = [cells objectAtIndex:6];
        [sele setExternalText:[dict objectForKey:@"value"]];
    }
}

extern bool isValidNumber(const char*);
- (void) handleTextFieldInput:(NSNotification*) notify
{
    UITextField *tf = [notify object];
    //NSLog(@"--%@--",nstr);
    const char *input = [tf.text UTF8String];
    if(!isValidNumber(input))
    {
        char tmp[50];
        strcpy(tmp, input);
        tmp[strlen(tmp)-1] = '\0';
        tf.text = [[NSString alloc] initWithCString:tmp 
                                           encoding:NSUTF8StringEncoding];
    };
}

-(void) click_calc
{
    bool b_input = true;
    struct input_prepayment_eq_installment peqi;
    MyTableViewCell *my = [cells objectAtIndex:0];
    const char *sz_loan_amount = [my.myTextField.text UTF8String];
    my = [cells objectAtIndex:1];
    const char *sz_loan_year = [my.myTextField.text UTF8String];
    my = [cells objectAtIndex:2];
    const char *sz_interest = [my.myTextField.text UTF8String];
    my = [cells objectAtIndex:3];
    const char *sz_paid_month = [my.myTextField.text UTF8String];
    my = [cells objectAtIndex:4];
    const char *sz_prepayment_type = [my.myLabel.text UTF8String];
    my = [cells objectAtIndex:5];
    const char *sz_payment_now = [my.myTextField.text UTF8String];
    my = [cells objectAtIndex:6];
    const char *sz_reduce_type = [my.myLabel.text UTF8String];
    
    //printf("%s,%s,%s,%s,%s,%s,%s\n",sz_loan_amount,sz_loan_year,sz_interest,sz_paid_month,
    //       sz_prepayment_type,sz_payment_now,sz_reduce_type);
    
    if(*sz_loan_amount==0 || sz_loan_year==0 || sz_interest==0 || sz_paid_month==0 || sz_payment_now==0)
    {
        b_input = false;
    }
    if (!b_input) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithCString:StringMgr::GetStringMgr()->GetDescript("STR_INPUT_ERROR").c_str() encoding:NSUTF8StringEncoding] delegate:self cancelButtonTitle:[NSString stringWithCString:StringMgr::GetStringMgr()->GetDescript("STR_CONFIRM").c_str() encoding:NSUTF8StringEncoding] otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    peqi.loan_amount = atof(sz_loan_amount) * 10000.0f;
    peqi.months_amount = atoi(sz_loan_year) * 12;
    peqi.interest_former = atof(sz_interest) / 100.0f;
    peqi.interest_new = peqi.interest_former;
    peqi.months_passed = atoi(sz_interest);
    peqi.wish_payment_this_month = atof(sz_payment_now) * 10000.0f;
    peqi.b_wish_pay_all = [pre_payment_type getSelectIndex];
    peqi.b_wish_reduce_payment_permonth = !([pre_payment_reduce_type getSelectIndex]);
    
    struct result_prepayment_eq_installment ret =  calc_prepayment_eq_installment(peqi);
    
    NSArray *cell_attributes = [NSArray arrayWithObjects:CELL_LEFT_TITLE,CELL_RIGHT_VALUE,nil];
    NSMutableArray *tnsma = [[NSMutableArray alloc] init];
    NSMutableDictionary* dict = nil;
    dict = [NSMutableDictionary dictionaryWithObjects:cell_values forKeys:cell_attributes];
    [tnsma addObject:dict];
    result_pre_payment = [[ResultTableViewController alloc] init:tnsma withStyle:UITableViewStylePlain];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.navigationController pushViewController:self.result_pre_payment animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldInput:) name:UITextFieldTextDidChangeNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOptionTableViewReturn:) name:@"OptionTableViewReturn" object:nil];
    
    [self.navigationItem setTitle:[NSString stringWithUTF8String:StringMgr::GetStringMgr()->GetDescript("STR_PERPAYMENT").c_str()]];

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithUTF8String:StringMgr::GetStringMgr()->GetDescript("STR_OK").c_str()] style:UIBarButtonItemStyleDone target:self action:@selector(click_calc)];
    [self.navigationItem setRightBarButtonItem:rightButton];
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
    return [cells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        MyTableViewCell *mycell = (MyTableViewCell*)[cells objectAtIndex:indexPath.row];
        cell = mycell.myTableViewCell;
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
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if (indexPath.row ==4) {
        [app.navigationController pushViewController:self.pre_payment_type animated:YES];
    }
    else if (indexPath.row ==6)
    {
        [app.navigationController pushViewController:self.pre_payment_reduce_type animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //g_EqInstalmentViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    //[self presentModalViewController:g_EqInstalmentViewController animated:YES];
    //[self.navigationController pushViewController:g_EqInstalmentViewController animated:YES];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.navigationController pushViewController:self.pre_payment_type animated:YES];
}

@end
