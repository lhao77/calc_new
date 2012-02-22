//
//  BaseViewController.m
//  tab
//
//  Created by lei zhang on 12-1-18.
//  Copyright (c) 2012年 gameloft. All rights reserved.
//

#import "BaseViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation BaseViewController

-(void)resignFirstResponderForAllSubTextFieldAndUITextView
{
    if([self.view.subviews count]>0)
    {
        for (UIView* curView in self.view.subviews) {
            if ([[curView description] hasPrefix:@"<UITextField"] == YES ||
                [[curView description] hasPrefix:@"<UITextView"] == YES) {
                [curView resignFirstResponder];
            }
        }
    }
}

-(void)initScreenTransparentButton
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = [[UIScreen mainScreen] bounds];
    [btn addTarget:self action:@selector(click_trans_btn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self.view sendSubviewToBack:btn];
}

- (IBAction)click_trans_btn:(id)sender {
    [self resignFirstResponderForAllSubTextFieldAndUITextView];
}


- (void)setBorder:(id)sender borderWidth:(double) width  color:(UIColor*)color
{
    if ([[sender description] hasPrefix:@"<UIButton"] == YES) {
        UIButton *btn = (UIButton*)sender;
        [btn.layer setBorderWidth:width];
        [btn.layer setBorderColor:color.CGColor];
    } else if ([[sender description] hasPrefix:@"<UITextView"] == YES){
        UITextView *btn = (UITextView*)sender;
        [btn.layer setBorderWidth:width];
        [btn.layer setBorderColor:color.CGColor];
    }
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initScreenTransparentButton];
    
    self.view.userInteractionEnabled =YES;
    //self.user
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldInput:) name:UITextFieldTextDidChangeNotification object:nil];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"%@",[[touches anyObject] locationInView:self.view]);
//}

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

extern bool isValidNumber(const char*);
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

@end
