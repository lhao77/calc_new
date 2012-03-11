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
    std::vector< std::vector<std::string> > texts;
    std::vector< std::vector<std::string> > values;
    
    int cell_type;
}

//-(void) setTexts:(std::vector<std::string>&)txts;
//-(void) setValues:(std::vector<std::string>&)vls;
//-(std::vector<std::string>) getValues;
-(void) setCell_type:(int)type;
-(int) getCell_type;

- (id)init:(UITableViewStyle)style withTexts:(std::vector< std::vector<std::string> >&) txts withValues:(std::vector< std::vector<std::string> >&) vls withCellType:(int)type;

-(NSString*) getCellValue:(int)index;
-(void) setCellValue:(int)index withValue:(NSString*)value;

-(CGRect) getTavbleViewCellsFrame;

@property (nonatomic, retain) NSMutableArray *m_cellControls;
@end
