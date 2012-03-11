//
//  TwoButton.h
//  calc
//这个控件的作用是实现一个类似于二中选一的功能。
//  Created by hao luo on 12-2-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

enum{
    SELECT_LEFT = 0,
    SELECT_RIGHT,
};


@interface TwoButton : UIView
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
