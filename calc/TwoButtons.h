//
//  TwoButtons.h
//  calc
//
//  Created by hao luo on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

enum{
    SELECT_LEFT = 0,
    SELECT_RIGHT,
};

@interface TwoButtons : UIViewController
{
    int value;
}

@property (nonatomic, retain) UIButton         *leftBtn;
@property (nonatomic, retain) UIButton         *rightBtn;

-(void) setValue:(int)_value;
-(int)  getValue;

-(id) init:(CGRect)frame leftTitle:(NSString*)lTitle rightTitle:(NSString*)rTitle;
-(void) setForLeftBtnClicked;
-(void) setForRightBtnClicked;
-(void) setButtonClicked:(UIButton*)button;
-(void) setBackgrounds:(UIButton*)button withColor:(UIColor*) color;
@end
