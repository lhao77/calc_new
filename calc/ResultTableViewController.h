//
//  ResultTableViewController.h
//  calc
//
//  Created by hao luo on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *nsma;

-(id) init:(NSMutableArray*)items withStyle:(UITableViewStyle)style;
@end
