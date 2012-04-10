//
//  EqualPaymentViewController.h
//  calc
//
//  Created by hao luo on 12-4-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionTableViewController.h"
#import "ResultTableViewController.h"
#import "MyTableViewCell.h"
#include "def.h"

@interface EqualPaymentViewController : UITableViewController<UITextFieldDelegate>
{
    struct input_eq_payment m_ineq;
    std::vector<int> vec_sels;
}
-(bool) is_calc_by_amount;
-(id) init:(NSMutableArray*)nsma withPaymentTypes:(NSMutableArray*)pts withStyle:(UITableViewStyle)style;
-(void) initCells;

@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) NSMutableArray *opt_types;

@property (nonatomic,strong) OptionTableViewController *option_payment_type;
@property (nonatomic,strong) ResultTableViewController *result_pre_payment;
@end
