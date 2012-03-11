//
//  EqpaymentViewController.h
//  calc
//
//  Created by hao luo on 12-2-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EqInputViewController.h"
#import "BaseViewController.h"
#import "OutputViewController.h"
#import "def.h"
//#import "TwoButtons.h"
#import "TwoButton.h"

@interface EqpaymentViewController : BaseViewController

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) OutputViewController *eqpayInputViewController;
@property (strong, nonatomic) OutputViewController *eqpayOutputViewController;

@property (strong, nonatomic) NSMutableArray *inputValues;
@property (strong, nonatomic) NSMutableArray *outputValues;
@property (strong, nonatomic) NSMutableArray *outputPermonthsValues;

//@property (strong, nonatomic) TwoButtons *two;
@property (strong, nonatomic) TwoButton *two;

@end