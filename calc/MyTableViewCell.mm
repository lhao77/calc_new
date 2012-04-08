//
//  MyTableViewCell.m
//  calc
//
//  Created by hao luo on 12-2-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyTableViewCell.h"

int getControllerType(NSString* str)
{
    const NSArray* controller_array = [NSArray arrayWithObjects:@"WITH_NONE",@"WITH_LABEL",@"WITH_TEXTFIELD",@"WITH_TWOBUTTON",nil];
//    for (int i=0; i<[controller_array count]; i++) {
//        if ([str isEqualToString:[controller_array objectAtIndex:i]]) {
//            return i;
//        }
//    }
    if ([str isEqualToString:[controller_array objectAtIndex:2]]) {
        return 2;
    }
    else
        return 1;
    
    assert("unkown controller type!!");
    return -1;
}

@implementation MyTableViewCell

@synthesize myTableViewCell;
@synthesize myLabel;
@synthesize myTextField;
@synthesize myTwoButton;
@synthesize value;

- (id)init:(CGRect)frame externalFrame:(CGRect)exframe type:(int) type
{
    if (self) {
        // Initialization code
        self.myTableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellReuseIdentifier"];
        [self.myTableViewCell setFrame:frame];
        self.myTableViewCell.editingAccessoryType = UITableViewCellAccessoryNone;
        
        self.type = type;
        if (type == WITH_LABEL) {
            self.myLabel = [[UILabel alloc] initWithFrame:exframe];
            [self.myTableViewCell addSubview:self.myLabel];
        }
        else if (type == WITH_TEXTFIELD)
        {
            self.myTextField = [[UITextField alloc] initWithFrame:exframe];
            myTextField.frame = exframe;
            [myTextField setBorderStyle:(UITextBorderStyle)UITextBorderStyleRoundedRect];
            myTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

            [self.myTableViewCell addSubview:self.myTextField];

        }
    }
    return self;
}

- (id)init:(CGRect)frame externalFrame:(CGRect)exframe type:(int) type accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    self = [self init:frame externalFrame:exframe type:type];
    self.myTableViewCell.accessoryType = accessoryType;
    return self;
}

- (void)setExternalText:(NSString*)nsexternal
{
    if (type == WITH_LABEL) {
        self.myLabel.text = nsexternal;
    }
    else if (type == WITH_TEXTFIELD)
    {
        self.myTextField.text = nsexternal;
    }
    
    [self setDefaultExternalColor];
}

- (void)setText:(NSString*)ns withExternalText:(NSString*)nsexternal
{
    self.myTableViewCell.text = ns;
    [self setExternalText:nsexternal];
}

- (id)init:(int)type
{
    return [self init:type accessoryType:UITableViewCellAccessoryNone];
}

- (id)init:(int)type accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    if (type == WITH_LABEL) {
        return [self init:CGRectMake(0.0, 0.0, 280.0, 40.0) externalFrame:CGRectMake(160.0, 0.0, 120.0, 40.0) type:type accessoryType:accessoryType];
    }
    else if (type == WITH_TEXTFIELD)
    {
        return [self init:CGRectMake(0.0, 0.0, 280.0, 40.0) externalFrame:CGRectMake(160.0, 2.0, 120.0, 38.0) type:type accessoryType:accessoryType];
    }
    else
    {
        return nil;
    }
}

+ (CGRect)getFrame
{
    return CGRectMake(0.0, 0.0, 280.0, 40.0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (int)type {
    return type;
}

- (void)setType:(int)newValue {
    type = newValue;
}

- (void)setColor:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    self.myTableViewCell.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (void)setExternalColor:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    if (self.type == WITH_LABEL) {
        self.myLabel.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }
    else if (self.type == WITH_TEXTFIELD)
    {
        self.myTextField.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }
}

- (void)setDefaultExternalColor
{
    [self setExternalColor:0.196 green:0.310 blue:0.522 alpha:1.000];
}

- (void)setFont:(UIFont*)font
{
    self.myTableViewCell.font = font;
}

- (void)setExternalFont:(UIFont*)font
{
    if (self.type == WITH_LABEL) {
        self.myLabel.font = font;
    }
    else if (self.type == WITH_TEXTFIELD)
    {
        self.myTextField.font = font;
    }
}

- (void)setDelegate:(id)delegate
{
    myTextField.delegate = delegate;
}

- (int)index {
    return index;
}

- (void)setIndex:(int)newValue {
    index = newValue;
}

@end
