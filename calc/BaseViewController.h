//
//  BaseViewController.h
//  tab
//
//  Created by lei zhang on 12-1-18.
//  Copyright (c) 2012年 gameloft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

-(void)resignFirstResponderForAllSubTextFieldAndUITextView;
-(void)initScreenTransparentButton;

- (void)setBorder:(id)sender borderWidth:(double) width  color:(UIColor*)color;

@end
