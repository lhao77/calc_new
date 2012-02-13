//
//  EqInoutViewController.h
//  calc
//
//  Created by hao luo on 12-2-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EqInputViewController : UIViewController

-(void)   clear;
-(void)   initText;
-(CGRect) getFrame;     //

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *amountLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *amountTxtField;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *interestLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *interestTxtField;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *yearLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *yearTxtField;

- (IBAction)click_ok:(id)sender;
- (IBAction)click_reset:(id)sender;
@end
