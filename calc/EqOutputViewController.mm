//
//  EqOutputViewController.m
//  calc
//
//  Created by hao luo on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EqOutputViewController.h"

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
@synthesize loan_monthsLabel;
@synthesize loan_monthsValueLabel;
@synthesize aver_paymentLabel;
@synthesize aver_paymentValueLabel;

- (void)clear
{
    house_amountValueLabel.text = @"";
    loan_amountValueLabel.text = @"";
    payment_amountValueLabel.text = @"";
    interest_amountValueLabel.text = @"";
    first_paymentValueLabel.text = @"";
    loan_monthsValueLabel.text = @"";
    aver_paymentValueLabel.text = @"";
}

-(void)   showResult:(NSArray*)nsarr
{
    house_amountValueLabel.text = (NSString*)[nsarr objectAtIndex:0];
    loan_amountValueLabel.text = (NSString*)[nsarr objectAtIndex:1];
    payment_amountValueLabel.text = (NSString*)[nsarr objectAtIndex:2];
    interest_amountValueLabel.text = (NSString*)[nsarr objectAtIndex:3];
    first_paymentValueLabel.text = (NSString*)[nsarr objectAtIndex:4];
    loan_monthsValueLabel.text = (NSString*)[nsarr objectAtIndex:5];
    aver_paymentValueLabel.text = (NSString*)[nsarr objectAtIndex:6];
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
    [self setLoan_monthsLabel:nil];
    [self setLoan_monthsValueLabel:nil];
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

@end
