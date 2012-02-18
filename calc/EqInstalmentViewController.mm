//
//  EqInstalmentViewController.m
//  calc
//
//  Created by hao luo on 12-2-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EqInstalmentViewController.h"

@implementation EqInstalmentViewController

@synthesize eqInputViewController;
@synthesize eqOutputViewController;

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
    
    self.eqInputViewController = [[EqInputViewController alloc] initWithNibName:nil bundle:nil];    
    [self.view addSubview:eqInputViewController.view];
    
    self.eqOutputViewController = [[EqOutputViewController alloc] initWithNibName:nil bundle:nil];
    self.eqOutputViewController.view.frame = CGRectMake(0,180,320,200);
    [self.view addSubview:eqOutputViewController.view];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)click_ok:(id)sender {
    if([self.eqInputViewController ISNotEmpty])
    {
        [self.eqInputViewController set_input_eq_payment];
        self.eqOutputViewController.m_output_eq_payment = calc_eq_installment_payment(self.eqInputViewController.m_input_eq_payment);
        [self.eqOutputViewController showResult];
    }
}

- (IBAction)click_reset:(id)sender {
    [self.eqInputViewController clear];
    [self.eqOutputViewController clear];
}
@end
