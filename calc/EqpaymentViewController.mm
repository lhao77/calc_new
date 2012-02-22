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
@synthesize eqpayInputViewController;
@synthesize eqpayOutputViewController;
@synthesize inputValues;
@synthesize outputValues;
@synthesize outputPermonthsValues;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (!inputValues) {
            inputValues = [[NSMutableArray alloc] init];
        }
        if (!outputValues) {
            outputValues = [[NSMutableArray alloc] init];
        }
        if (!outputPermonthsValues) {
            outputPermonthsValues = [[NSMutableArray alloc] init];
        }
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

-(void)getInputValues
{
    int count = [self.eqpayInputViewController.m_cellControls count];
    for (int i=0; i<count; i++) {
        NSString* nstr = [self.eqpayInputViewController getCellValue:i];
        //NSLog(@"%@",nstr);
        [inputValues addObject:nstr];
    }
}

-(void)calc
{
    struct input_eq_payment             in;
    struct output_eq_interest_payment   out;
    
    in.b_calc_by_loan_amount = true;
    in.loan_amount = atof([(NSString*)[inputValues objectAtIndex:0] UTF8String])*10000;
    in.months = atof([(NSString*)[inputValues objectAtIndex:1] UTF8String])*12;
    in.interest = atof([(NSString*)[inputValues objectAtIndex:2] UTF8String])/100;
    
    out = calc_eq_interest_payment(in);
    char buf[20];
    sprintf(buf, "%.2f", out.house_price);
    [outputValues addObject:[NSString stringWithCString:buf encoding:NSUTF8StringEncoding]];
    sprintf(buf, "%.2f", out.initial_payment);
    [outputValues addObject:[NSString stringWithCString:buf encoding:NSUTF8StringEncoding]];
    sprintf(buf, "%.2f", out.loan_amount);
    [outputValues addObject:[NSString stringWithCString:buf encoding:NSUTF8StringEncoding]];
    sprintf(buf, "%.2f", out.payment_amount);
    [outputValues addObject:[NSString stringWithCString:buf encoding:NSUTF8StringEncoding]];
    sprintf(buf, "%.2f", out.interest_amount);
    [outputValues addObject:[NSString stringWithCString:buf encoding:NSUTF8StringEncoding]];
    
    for (int i=0; i<out.vec_payment_permonth.size(); i++) {
        sprintf(buf, "%.2f",out.vec_payment_permonth[i]);
        [outputPermonthsValues addObject:[NSString stringWithCString:buf encoding:NSUTF8StringEncoding]];
    }
}

-(void)showResult
{
    int count = [self.eqpayOutputViewController.m_cellControls count];
    for (int i=0; i<count; i++) {
        [self.eqpayOutputViewController setCellValue:i withValue:(NSString*)[outputValues objectAtIndex:i]];
    }
}

-(void)click_ok:(id)sender
{
    [self getInputValues];
    [self calc];
    [self showResult];
}

-(void)click_reset:(id)sender
{
    int i = 3;
}

- (UIButton*)createButton:(SEL)sel withFrame:(CGRect) rect
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button.frame = rect;
    // 注册按钮按下时的处理函数
    [button addTarget:self action:sel
       forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)initOk_ResetButton
{
    const float button_width = 100.0f;
    const float button_height = 40.0f;
    CGRect rect = [self.eqpayInputViewController getFrame];

    [self.mainScrollView addSubview:[self createButton:(@selector(click_ok:)) withFrame:CGRectMake(320/2-button_width-20,(rect.origin.y+rect.size.height+40),button_width,button_height)]];
    [self.mainScrollView addSubview:[self createButton:(@selector(click_reset:)) withFrame:CGRectMake(320/2+20,(rect.origin.y+rect.size.height+40),button_width,button_height)]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.mainScrollView addSubview:eqpayInputViewController.view];
    
    const float button_width = 100.0f;
    const float button_height = 40.0f;
    CGRect rect = [self.eqpayInputViewController getFrame];
    
    [self.mainScrollView addSubview:[self createButton:(@selector(click_ok:)) withFrame:CGRectMake(320/2-button_width-20,(rect.origin.y+rect.size.height+40),button_width,button_height)]];
    [self.mainScrollView addSubview:[self createButton:(@selector(click_reset:)) withFrame:CGRectMake(320/2+20,(rect.origin.y+rect.size.height+40),button_width,button_height)]];

    CGRect out_rect = [self.eqpayOutputViewController getFrame];
    eqpayOutputViewController.view.frame = CGRectMake(0, rect.origin.y+rect.size.height+80, 320, out_rect.size.height+80);
    
    [self.mainScrollView addSubview:eqpayOutputViewController.view];
    [self.mainScrollView setContentSize:CGSizeMake(320,800)];
    self.mainScrollView.delegate = (id)self;
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
