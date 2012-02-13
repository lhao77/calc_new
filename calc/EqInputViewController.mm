//
//  EqInoutViewController.m
//  calc
//
//  Created by hao luo on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EqInputViewController.h"
#include "StringMgr.h"

@implementation EqInputViewController
@synthesize amountLabel;
@synthesize amountTxtField;
@synthesize interestLabel;
@synthesize interestTxtField;
@synthesize yearLabel;
@synthesize yearTxtField;


-(void) clear
{
    self.amountTxtField.text = @"";
    self.interestTxtField.text = @"";
    self.yearTxtField.text = @"";
}

-(void) initText
{
    StringMgr *str_mgr = StringMgr::GetStringMgr();
    self.amountLabel.text = [NSString stringWithUTF8String:str_mgr->GetDescript("STR_LOAN_AMOUNT", 1).c_str()];
    self.interestLabel.text = [NSString stringWithUTF8String:str_mgr->GetDescript("STR_LOAN_INTEREST", 1).c_str()];
    self.yearLabel.text = [NSString stringWithUTF8String:str_mgr->GetDescript("STR_LOAN_YEAR", 1).c_str()];
    
    [self clear];
}

extern bool isValidNumber(const char *src);

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    // Do any additional setup after loading the view from its nib.
    self.amountTxtField.delegate = (id)self;
    self.interestTxtField.delegate = (id)self;
    self.yearTxtField.delegate = (id)self;
    
    [self initText];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldInput:) name:UITextFieldTextDidChangeNotification object:nil];
    self.view.frame = [self getFrame];
    
}

- (void)viewDidUnload
{
    [self setYearTxtField:nil];
    [self setYearLabel:nil];
    [self setInterestLabel:nil];
    [self setInterestTxtField:nil];
    [self setAmountLabel:nil];
    [self setAmountTxtField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(CGRect) getFrame
{
    return CGRectMake(0.0f,0.0f,320.0f,220.0f);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)click_ok:(id)sender {
}

- (IBAction)click_reset:(id)sender {
}
@end
