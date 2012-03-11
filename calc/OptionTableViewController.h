//
//  OptionTableViewController.h
//  calc
//
//  Created by hao luo on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionTableViewController : UITableViewController
{
    int selectIndex;
    int parentTag;
}

-(void) setSelectIndex:(int)idx;
-(int)  getSelectIndex;

-(void) setParentTag:(int)idx;
-(int)  getParentTag;

-(id)init:(UITableViewStyle)style withItems:(NSMutableArray*)items withSelectIndex:(int)idx withParentTag:(int)itag;

@property (nonatomic,strong) NSMutableArray *nsma;
@end
