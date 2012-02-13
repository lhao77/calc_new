//
//  EqOutputViewController.h
//  calc
//
//  Created by hao luo on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EqOutputViewController : UIViewController

-(CGRect) getFrame;
-(void)   clear;
-(void)   showResult:(NSArray*)nsarr;

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
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *loan_monthsLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *loan_monthsValueLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *aver_paymentLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *aver_paymentValueLabel;


@end
