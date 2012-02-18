//
//  EqOutputViewController.h
//  calc
//
//  Created by hao luo on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "def.h"

@interface EqOutputViewController : UIViewController

-(void) initText;
-(CGRect) getFrame;
-(void)   clear;
-(void)   showResult;

@property (unsafe_unretained, nonatomic) struct output_eq_installment_payment m_output_eq_payment;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *house_amountLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *house_amountValueLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *loan_amountLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *loan_amountValueLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *payment_amountLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *payment_amountValueLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *interest_amountLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *interest_amountValueLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *first_paymentLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *first_paymentValueLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *aver_paymentLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *aver_paymentValueLabel;


@end
