//
//  EqOutputViewController.m
//  calc
//
//  Created by hao luo on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EqOutputViewController.h"
#include "StringMgr.h"

@implementation EqOutputViewController
@synthesize house_amountLabel;
@synthesize house_amountValueLabel;
@synthesize loan_amountLabel;
@synthesize loan_amountValueLabel;
@synthesize payment_amountLabel;
@synthesize payment_amountValueLabel;
@synthesize interest_amountLabel;
@synthesize interest_amountValueLabel;
@synthesize first_paymentLabel;
@synthesize first_paymentValueLabel;
@synthesize aver_paymentLabel;
@synthesize aver_paymentValueLabel;

@synthesize m_output_eq_payment = _m_output_eq_payment;

- (void)clear
{
    house_amountValueLabel.text = @"";
    loan_amountValueLabel.text = @"";
    payment_amountValueLabel.text = @"";
    interest_amountValueLabel.text = @"";
    first_paymentValueLabel.text = @"";
    aver_paymentValueLabel.text = @"";
}

-(void)   showResult
{
    char buf[50];
    sprintf(buf,"%.2f",self.m_output_eq_payment.house_price);
    house_amountValueLabel.text = [[NSString alloc] initWithCString:buf 
                                                           encoding:NSUTF8StringEncoding];
    sprintf(buf,"%.2f",self.m_output_eq_payment.loan_amount);
    loan_amountValueLabel.text = [[NSString alloc] initWithCString:buf 
                                                           encoding:NSUTF8StringEncoding];
    sprintf(buf,"%.2f",self.m_output_eq_payment.payment_amount);
    payment_amountValueLabel.text = [[NSString alloc] initWithCString:buf 
                                                           encoding:NSUTF8StringEncoding];
    sprintf(buf,"%.2f",self.m_output_eq_payment.interest_amount);
    interest_amountValueLabel.text = [[NSString alloc] initWithCString:buf 
                                                           encoding:NSUTF8StringEncoding];
    sprintf(buf,"%.2f",self.m_output_eq_payment.initial_payment);
    first_paymentValueLabel.text = [[NSString alloc] initWithCString:buf 
                                                           encoding:NSUTF8StringEncoding];
//    sprintf(buf,"%f",self.m_output_eq_payment.house_price);
//    loan_monthsValueLabel.text = [[NSString alloc] initWithCString:buf 
//                                                           encoding:NSUTF8StringEncoding];
    sprintf(buf,"%.2f",self.m_output_eq_payment.payment_permonth);
    aver_paymentValueLabel.text = [[NSString alloc] initWithCString:buf 
                                                           encoding:NSUTF8StringEncoding];
    
//    loan_amountValueLabel.text = (NSString*)[nsarr objectAtIndex:1];
//    payment_amountValueLabel.text = (NSString*)[nsarr objectAtIndex:2];
//    interest_amountValueLabel.text = (NSString*)[nsarr objectAtIndex:3];
//    first_paymentValueLabel.text = (NSString*)[nsarr objectAtIndex:4];
//    loan_monthsValueLabel.text = (NSString*)[nsarr objectAtIndex:5];
//    aver_paymentValueLabel.text = (NSString*)[nsarr objectAtIndex:6];
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
    [self initText];
}

- (void)viewDidUnload
{
    [self setHouse_amountLabel:nil];
    [self setHouse_amountValueLabel:nil];
    [self setLoan_amountLabel:nil];
    [self setLoan_amountValueLabel:nil];
    [self setPayment_amountLabel:nil];
    [self setPayment_amountValueLabel:nil];
    [self setInterest_amountLabel:nil];
    [self setInterest_amountValueLabel:nil];
    [self setFirst_paymentLabel:nil];
    [self setFirst_paymentValueLabel:nil];
    [self setAver_paymentLabel:nil];
    [self setAver_paymentValueLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(CGRect) getFrame
{
    return CGRectMake(0.0f,0.0f,320.0f,200.0f);
}

-(void) initText
{
    StringMgr *str_mgr = StringMgr::GetStringMgr();
    self.house_amountLabel.text = [NSString stringWithUTF8String:str_mgr->GetDescript("STR_HOUSE_PRICE", 1).c_str()];self.loan_amountLabel.text = [NSString stringWithUTF8String:str_mgr->GetDescript("STR_LOAN_AMOUNT", 1).c_str()];
    self.loan_amountLabel.text = [NSString stringWithUTF8String:str_mgr->GetDescript("STR_LOAN_AMOUNT", 1).c_str()];
    self.payment_amountLabel.text = [NSString stringWithUTF8String:str_mgr->GetDescript("STR_PAYENT_AMOUNT", 1).c_str()];
    self.interest_amountLabel.text = [NSString stringWithUTF8String:str_mgr->GetDescript("STR_INTERST_AMOUNT", 1).c_str()];
    self.first_paymentLabel.text = [NSString stringWithUTF8String:str_mgr->GetDescript("STR_INITIAL_PAYMENT", 1).c_str()];
    self.aver_paymentLabel.text = [NSString stringWithUTF8String:str_mgr->GetDescript("STR_PAYENT_PER_MONTH", 1).c_str()];
            
    [self clear];
}
@end
