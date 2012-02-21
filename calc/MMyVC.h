//
//  MMyVC.h
//  calc
//
//  Created by hao luo on 12-2-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutputViewController.h"
#include <string>

enum
{
    WITH_NONE = 0,
    WITH_LABEL,
    WITH_TEXTFIELD,
};

@interface MMyVC : UIViewController
{
    int             type;
    int             index;
    //std::string&    str;
}

@property (nonatomic, retain) OutputViewController      *outputViewController;
@property (nonatomic, retain) NSString        *value;
@property (nonatomic, retain) UITableViewCell *myTableViewCell;
@property (nonatomic, retain) UILabel         *myLabel;
@property (nonatomic, retain) UITextField     *myTextField;



- (int)type;
- (void)setType:(int)newValue;
- (void)setColor:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (void)setExternalColor:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (void)setFont:(UIFont*)font;
- (void)setExternalFont:(UIFont*)font;

- (void)setText:(NSString*)ns withExternalText:(NSString*)nsexternal;
- (void)setDelegate:(id)delegate;

- (id)init:(CGRect)frame externalFrame:(CGRect)exframe type:(int) type;
- (id)init:(int)type;

- (int)index;
- (void)setIndex:(int)newValue;

- (void)setOutputViewController:(OutputViewController *)outputViewController;
@end
