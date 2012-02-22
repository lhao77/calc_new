//
//  EqpaymentViewController.m
//  calc
//
//  Created by hao luo on 12-2-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EqpaymentViewController.h"

@implementation EqpaymentViewController
@synthesize mainScrollView;
@synthesize eqInputViewController;

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

-(void)click_ok:(id)sender
{
    int i = 3;
}

- (UIButton*)createButton:(int)startHeight
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    int width = 100;
    button.frame = CGRectMake(320/2-width-20,startHeight,width,40);
    // 注册按钮按下时的处理函数
    [button addTarget:self action:@selector(click_ok:)
       forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.mainScrollView addSubview:eqInputViewController.view];
    [self.mainScrollView setContentSize:CGSizeMake(320,800)];
    self.mainScrollView.delegate = (id)self;
    
    CGRect rect = [self.eqInputViewController getFrame];
    [self.mainScrollView addSubview:[self createButton:(rect.origin.y+rect.size.height+40)]];

}

- (void)viewDidUnload
{
    [self setMainScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
