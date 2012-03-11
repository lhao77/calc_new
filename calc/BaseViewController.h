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

- (void) handleTextFieldInput:(NSNotification*) notify;

- (UIButton*)createButton:(SEL)sel withFrame:(CGRect) rect withTitle:(NSString*)title;

@property (strong, nonatomic) UIButton *ok_button;
@property (strong, nonatomic) UIButton *reset_button;

@end
