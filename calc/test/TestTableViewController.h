//
//  TestTableViewController.h
//  calc
//
//  Created by hao luo on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


struct Item
{
    char        *title;
    int         tag;
    int         type;
};


@interface TestTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *items;
@end
