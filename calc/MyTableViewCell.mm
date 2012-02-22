//
//  MyTableViewCell.m
//  calc
//
//  Created by hao luo on 12-2-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyTableViewCell.h"
#import "OutputViewController.h"


@implementation MyTableViewCell

@synthesize myTableViewCell;
@synthesize myLabel;
@synthesize myTextField;
@synthesize value;
@synthesize outputViewController;

- (id)init:(CGRect)frame externalFrame:(CGRect)exframe type:(int) type
{
    if (self) {
        // Initialization code
        self.myTableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellReuseIdentifier"];
        self.myTableViewCell.frame = frame;
        self.myTableViewCell.editingAccessoryType = UITableViewCellAccessoryNone;
        
        self.type = type;
        if (type == WITH_LABEL) {
            self.myLabel = [[UILabel alloc] initWithFrame:exframe];
            [self.myTableViewCell addSubview:self.myLabel];
        }
        else if (type == WITH_TEXTFIELD)
        {
            self.myTextField = [[UITextField alloc] initWithFrame:exframe];
            [self.myTableViewCell addSubview:self.myTextField];
            self.myTextField.delegate = (id)self;
        }
    }
    return self;
}

- (void)setOutputViewController:(OutputViewController *)outputViewController
{
    self.outputViewController = outputViewController;
}

- (void)setValueByIndex:(int)idx withTextFieldValue:(NSString*)ns
{
    const char *tmp = [ns UTF8String];
    std::string &str = [outputViewController getValues][idx];
    str = tmp;
}

- (void)setText:(NSString*)ns withExternalText:(NSString*)nsexternal
{
    self.myTableViewCell.text = ns;
    
    if (type==WITH_LABEL) {
        self.myLabel.text = nsexternal;
    }
    else if (type == WITH_TEXTFIELD)
    {
        self.myTextField.text = nsexternal;
    }
}

- (id)init:(int)type
{
    return [self init:CGRectMake(20.0, 0.0, 280.0, 50.0) externalFrame:CGRectMake(160.0, 10.0, 120.0, 40.0) type:type];
}

+ (CGRect)getFrame
{
    return CGRectMake(20.0, 0.0, 280.0, 50.0);
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
    //self.myTextField.delegate = delegate;
}

- (int)index {
    return index;
}

- (void)setIndex:(int)newValue {
    index = newValue;
}

@end
