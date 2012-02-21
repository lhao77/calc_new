//
//  OutputViewController.h
//  calc
//
//  Created by hao luo on 12-2-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#include <string>
#include <vector>

#import "MyTableViewCell.h"

@interface OutputViewController : UITableViewController
{
    std::vector<std::string> texts;
    std::vector<std::string> values;
    
    int cell_type;
}

-(void) setTexts:(std::vector<std::string>&)txts;
-(void) setValues:(std::vector<std::string>&)vls;
-(std::vector<std::string>) getValues;
-(void) setCell_type:(int)type;
-(int) getCell_type;

- (id)init:(UITableViewStyle)style withTexts:(std::vector<std::string>&) txts withValues:(std::vector<std::string>&) vls withCellType:(int)type;

@property (nonatomic, retain) NSArray *m_nsarray1;
@property (nonatomic, retain) NSArray *m_nsarray2;
@end
