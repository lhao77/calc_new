//
//  TwoButton.m
//  calc
//
//  Created by hao luo on 12-2-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TwoButton.h"

@implementation TwoButton
@synthesize leftBtn;
@synthesize rightBtn;

-(void)click:(id)sender
{
    [self setButtonClicked:(UIButton*)sender];
}

- (UIButton*)createButton:(SEL)sel withFrame:(CGRect) rect withTitle:(NSString*)title
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setAlpha:0.5];
    [button setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2]];
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
        
        self = [self initWithFrame:frame];
        [self addSubview:leftBtn];
        [self addSubview:rightBtn];
        
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

@end
