//
//  TwoButtons.m
//  calc
//
//  Created by hao luo on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TwoButtons.h"

@implementation TwoButtons

@synthesize leftBtn;
@synthesize rightBtn;

-(void)click:(id)sender
{
    [self setButtonClicked:(UIButton*)sender];
}

- (UIButton*)createButton:(SEL)sel withFrame:(CGRect) rect withTitle:(NSString*)title
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = rect;
    // 注册按钮按下时的处理函数
    [button addTarget:self action:sel
     forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(id) init:(CGRect)frame leftTitle:(NSString *)lTitle rightTitle:(NSString *)rTitle
{
    self = [super init];
    if (self) {
        CGRect lframe = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width/2, frame.size.height);
        CGRect rframe = CGRectMake(frame.origin.x+frame.size.width/2, frame.origin.y, frame.size.width/2, frame.size.height);
        
        leftBtn = [self createButton:@selector(click:) withFrame:lframe withTitle:lTitle];
        rightBtn = [self createButton:@selector(click:) withFrame:rframe withTitle:rTitle];
        
        [self setButtonClicked:leftBtn];
        
        self.view = [[UIView alloc] initWithFrame:frame];
        [self.view addSubview:leftBtn];
        [self.view addSubview:rightBtn];
        
    }
    
    return self;
}

-(void) setBackgrounds:(UIButton*)button withColor:(UIColor*) color
{
    button.backgroundColor = color;
}

-(void) setButtonClicked:(UIButton*)button
{
    if (button == leftBtn) {
        [self setValue:SELECT_LEFT];
        button.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
        rightBtn.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.2];
    }
    else if (button == rightBtn) {
        [self setValue:SELECT_RIGHT];
        button.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
        leftBtn.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.2];
    }
}

-(void) setValue:(int)_value
{
    value = _value;
}

-(int)  getValue
{
    return value;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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

@end
