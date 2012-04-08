//
//  ResultTableViewController.h
//  calc
//
//  Created by hao luo on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *nsma_lt;
@property (nonatomic,strong) NSMutableArray *nsma_rv;
-(id) init:(NSMutableArray*)items withValue:(NSMutableArray*)items1 withStyle:(UITableViewStyle)style;
@end
