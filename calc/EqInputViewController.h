//
//  EqInoutViewController.h
//  calc
//
//  Created by hao luo on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "def.h"

@interface EqInputViewController : UIViewController

- (BOOL) ISNotEmpty;
-(void)   clear;
-(void)   initText;
-(CGRect) getFrame;     //

@property (unsafe_unretained, nonatomic) struct input_eq_payment m_input_eq_payment;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *amountLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *amountTxtField;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *interestLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *interestTxtField;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *yearLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *yearTxtField;


- (void) set_input_eq_payment;
- (void) show_output_eq_payment;

@end
