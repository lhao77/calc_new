//
//  PrepaymentViewController.h
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

@interface PrepaymentViewController : BaseViewController

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) OutputViewController *preInputViewController;
@property (strong, nonatomic) OutputViewController *preOutputViewController;
@end