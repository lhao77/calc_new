//
//  PrepaymentViewController.h
//  calc
//
//  Created by hao luo on 12-3-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionTableViewController.h"
#import "MyTableViewCell.h"
#include "def.h"


@interface PrepaymentViewController : UITableViewController<UITextFieldDelegate>
{
    struct input_prepayment_eq_installment m_in_pre;
}

-(id) init:(NSMutableArray*)nsma withPreTypes:(NSMutableArray*)pts withPreReduceTypes:(NSMutableArray*)prts withStyle:(UITableViewStyle)style;
-(void) initCells;
//-(void) set_input_prepayment_eq_installment;

@property (nonatomic,strong) NSMutableArray *cells;

@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) NSMutableArray *pre_types;
@property (nonatomic,strong) NSMutableArray *pre_reduce_types;

@property (nonatomic,strong) OptionTableViewController *pre_payment_type;
@property (nonatomic,strong) OptionTableViewController *pre_payment_reduce_type;

@end
