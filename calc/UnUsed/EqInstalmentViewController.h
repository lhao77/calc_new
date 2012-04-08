//
//  EqInstalmentViewController.h
//  calc
//
//  Created by hao luo on 12-2-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>

#import "EqInputViewController.h"
#import "EqOutputViewController.h"
#import "def.h"

@interface EqInstalmentViewController : BaseViewController

@property (strong, nonatomic) EqInputViewController *eqInputViewController;
@property (strong, nonatomic) EqOutputViewController *eqOutputViewController;

- (IBAction)click_ok:(id)sender;
- (IBAction)click_reset:(id)sender;

@end
