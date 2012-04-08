//
//  MMyVC.m
//  calc
//
//  Created by hao luo on 12-2-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MMyVC.h"

@implementation MMyVC

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
    
    [myTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldInput:) name:UITextFieldTextDidChangeNotification object:nil];
    
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
    return [self init:CGRectMake(20.0, 70.0, 280.0, 50.0) externalFrame:CGRectMake(160.0, 2.0, 120.0, 40.0) type:type];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self setValueByIndex:index withTextFieldValue:textField.text];
    [textField resignFirstResponder];
    return YES;
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
