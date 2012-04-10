//
//  EqualPaymentViewController.m
//  calc
//
//  Created by hao luo on 12-4-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EqualPaymentViewController.h"
#import "AppDelegate.h"
#include "StringMgr.h"

extern NSMutableArray* convert_output_eq_installment_payment_to_array(output_eq_installment_payment ret);
extern NSMutableArray* get_output_eq_installment_payment(bool b_calc_by_loan_amount);

const int area_num = 5;
const int amount_num = 4;
const int area_indexs[] = {0,3,4,5,6};
const int amount_indexs[] = {0,1,2,6};

@implementation EqualPaymentViewController

@synthesize items;
@synthesize cells;
@synthesize opt_types;
@synthesize result_pre_payment;
@synthesize option_payment_type;
/*
 items结构是字典的组合:
 "title","..."
 "rvalue","..."
 "rutil","..."
 "rcontroltype","..."
 "accessorytype","..."
 "tag","..."
 */

-(id) init:(NSMutableArray*)nsma withPaymentTypes:(NSMutableArray*)pts withStyle:(UITableViewStyle)style
{
    self.items = nsma;
    self.opt_types = pts;
    
    self.option_payment_type = [[OptionTableViewController alloc] init:UITableViewStylePlain withItems:opt_types withSelectIndex:0 withParentTag:0];
    
    [self initCells];
    
    m_ineq.b_calc_by_loan_amount = true;
    
    vec_sels.clear();
    for (int i=0; i<amount_num; ++i) {
        vec_sels.push_back(amount_indexs[i]);
    }
    
    return [self initWithStyle:style];
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
    [mycell setFont:[UIFont systemFontOfSize:17]];
    [mycell setExternalFont:[UIFont systemFontOfSize:17]];
    
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

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void) handleOption:(int)tag
{
    if (tag==0) {//按贷款总额计算
        vec_sels.clear();
        for (int i=0; i<amount_num; ++i) {
            vec_sels.push_back(amount_indexs[i]);
        }
    }
    else
    {
        vec_sels.clear();
        for (int i=0; i<area_num; ++i) {
            vec_sels.push_back(area_indexs[i]);
        }
    }
    [self.tableView reloadData];
}

- (void) handleOptionTableViewReturn:(NSNotification *)notification
{
    NSMutableDictionary *dict = [notification object];
    NSLog(@"dict=%@\n",dict);
    NSString *parentTag = (NSString*)[dict objectForKey:@"parentTag"];
    const char *sz_parentTag = [parentTag UTF8String];
    int nParentTag = atoi(sz_parentTag);
    MyTableViewCell *sele = [cells objectAtIndex:nParentTag];
    [sele setExternalText:[dict objectForKey:@"value"]];
    
    if (nParentTag==0) {
        NSIndexPath *idx = [dict objectForKey:@"indexPath"];
        [self handleOption:idx.row];
    }
}

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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(bool) is_calc_by_amount
{
    return (vec_sels.size()==amount_num);
}
-(const char*) getValue:(int) idx withErrorId:(int*) pid
{
    MyTableViewCell *my = [cells objectAtIndex:idx];
    const char *ret = [my.myTextField.text UTF8String];
    if (*ret==0) {
        *pid = idx;
    }
    return ret;
}
-(void) click_calc
{
    int error_input_id = -1;
    struct input_eq_payment eqi;
    NSString *msg = [NSString stringWithCString:StringMgr::GetStringMgr()->GetDescript("STR_PLEASE_INPUT").c_str() encoding:NSUTF8StringEncoding];
    MyTableViewCell *my = Nil;
    //顺序为621，543，目的是为了获取error_input_id时每次能获得最小的值。
    if ([self is_calc_by_amount]) {
        const char *sz_interest = [self getValue:6 withErrorId:&error_input_id];
        const char *sz_loan_year = [self getValue:2 withErrorId:&error_input_id];
        const char *sz_loan_amount = [self getValue:1 withErrorId:&error_input_id]; 
        eqi.loan_amount = atof(sz_loan_amount) * 10000.0f;
        eqi.months = atoi(sz_loan_year) * 12;
        eqi.interest = atof(sz_interest) / 100.0f;
        eqi.b_calc_by_loan_amount = true;
    }
    else
    {
        const char *sz_interest = [self getValue:6 withErrorId:&error_input_id];
        const char *sz_percent = [self getValue:5 withErrorId:&error_input_id];
        const char *sz_house_price_m2 = [self getValue:4 withErrorId:&error_input_id];
        const char *sz_house_area = [self getValue:3 withErrorId:&error_input_id];
        eqi.area = atof(sz_house_area);
        eqi.price_per_centiare = atof(sz_house_price_m2);
        eqi.mortgage_percentage = atoi(sz_percent) / 100.0f;
        eqi.interest = atof(sz_interest) / 100.0f;
        eqi.b_calc_by_loan_amount = false;
        
        if (eqi.mortgage_percentage>0.99f && error_input_id>5) {
            error_input_id = 5;
            [msg stringByAppendingFormat:@"%@",[NSString stringWithCString:StringMgr::GetStringMgr()->GetDescript("STR_REAL").c_str() encoding:NSUTF8StringEncoding]];
        }
    }
        
    if (eqi.interest>0.5f && error_input_id==-1) {
        error_input_id = 6;
        msg = [msg stringByAppendingFormat:@"%@",[NSString stringWithCString:StringMgr::GetStringMgr()->GetDescript("STR_REAL").c_str() encoding:NSUTF8StringEncoding]];
    }
    
    if (error_input_id != -1) {
        NSString* err_msg = [NSString stringWithFormat:@"%@%@.",msg,(NSString*)[(NSMutableDictionary*)[self.items objectAtIndex:error_input_id] objectForKey: CELL_LEFT_TITLE]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:err_msg delegate:self cancelButtonTitle:[NSString stringWithCString:StringMgr::GetStringMgr()->GetDescript("STR_CONFIRM").c_str() encoding:NSUTF8StringEncoding] otherButtonTitles:nil];
        [alert show];
        return;
    }

    
    struct output_eq_installment_payment ret = calc_eq_installment_payment(eqi);
    NSMutableArray *tnsma = get_output_eq_installment_payment(ret.b_calc_by_loan_amount);
    NSMutableArray *tnsma1 = convert_output_eq_installment_payment_to_array(ret);
    
    result_pre_payment = [[ResultTableViewController alloc] init:tnsma withValue:tnsma1 withStyle:UITableViewStylePlain];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.navigationController pushViewController:self.result_pre_payment animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldInput:) name:UITextFieldTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOptionTableViewReturn:) name:@"OptionTableViewReturn" object:nil];

    [self.navigationItem setTitle:[NSString stringWithUTF8String:StringMgr::GetStringMgr()->GetDescript("STR_PERPAYMENT").c_str()]];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithUTF8String:StringMgr::GetStringMgr()->GetDescript("STR_OK").c_str()] style:UIBarButtonItemStyleDone target:self action:@selector(click_calc)];
    [self.navigationItem setRightBarButtonItem:rightButton];}

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
    return vec_sels.size();
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        MyTableViewCell *mycell = (MyTableViewCell*)[cells objectAtIndex:vec_sels[indexPath.row]];
        cell = mycell.myTableViewCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if (indexPath.row ==0) {
        [app.navigationController pushViewController:self.option_payment_type animated:YES];
    }
}

@end
