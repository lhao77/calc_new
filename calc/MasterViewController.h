//
//  MasterViewController.h
//  calc
//
//  Created by hao luo on 12-2-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class EqInstalmentViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) EqInstalmentViewController *eqInstalmentViewController;

@end
