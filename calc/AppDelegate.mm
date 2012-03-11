//
//  AppDelegate.m
//  calc
//
//  Created by hao luo on 12-2-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "EqInstalmentViewController.h"
#import "OutputViewController.h"
#import "EqpaymentViewController.h"
#include "def.h"
#include "StringMgr.h"

#import "PrepaymentViewController.h"

std::vector< Functions > g_type_func;

StringMgr* strMgr = StringMgr::GetStringMgr();

void init_map_func()
{
    std::vector<std::string> vs;
    struct Functions fs;
    vs.push_back("等额本金");
    vs.push_back("等额本息");
    fs = Functions(std::string("房产"),vs);
    g_type_func.push_back(fs);
    
    vs.clear();
    
    vs.push_back("unkown");
    fs = Functions(std::string("unkown"),vs);
    g_type_func.push_back(fs);
}

extern std::string xml_path;
void init_string()
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"string.xml" ofType:@""];
    NSLog(@"--%@--",path);
    xml_path = [path UTF8String];
    StringMgr::GetStringMgr()->init();
    StringMgr::GetStringMgr()->setLang_idx(1);
}

UITableViewCellAccessoryType getTableViewCellAccessoryType(NSString* str)
{
    if ([str isEqualToString:@"UITableViewCellAccessoryNone"]) {
        return UITableViewCellAccessoryNone;
    }
    else if ([str isEqualToString:@"UITableViewCellAccessoryDisclosureIndicator"]) {
        return UITableViewCellAccessoryDisclosureIndicator;
    }
    else if ([str isEqualToString:@"UITableViewCellAccessoryDetailDisclosureButton"]) {
        return UITableViewCellAccessoryDetailDisclosureButton;
    }
    else if ([str isEqualToString:@"UITableViewCellAccessoryCheckmark"]) {
        return UITableViewCellAccessoryCheckmark;
    }
    else
    {
        ASSERT("error accessoryType!!");
        return (UITableViewCellAccessoryType)-1;
    }
}

EqInstalmentViewController *g_EqInstalmentViewController;
OutputViewController *g_eqInputViewController;
OutputViewController *g_preOutputViewController;

OutputViewController *g_eqpayInputViewController;
OutputViewController *g_eqpayOutputViewController;
OutputViewController *g_eqpayPerMonthOutputViewController;
EqpaymentViewController *g_eqpayViewController;

PrepaymentViewController *g_prepaymentViewController;

NSString* CELL_LEFT_TITLE = [NSString stringWithCString:"title" encoding:NSUTF8StringEncoding];
NSString* CELL_RIGHT_VALUE = [NSString stringWithCString:"rvalue" encoding:NSUTF8StringEncoding];
NSString* CELL_RIGHT_UTIL = [NSString stringWithCString:"rutil" encoding:NSUTF8StringEncoding];
NSString* CELL_RIGHT_CONTROLTYPE = [NSString stringWithCString:"rcontroltype" encoding:NSUTF8StringEncoding];
NSString* CELL_ACCESSORYTYPE = [NSString stringWithCString:"accessorytype" encoding:NSUTF8StringEncoding];
NSString* CELL_TAG = [NSString stringWithCString:"tag" encoding:NSUTF8StringEncoding];

//初始化提前还贷ViewController
void initPrepaymentViewController()
{
    NSMutableArray* nsma = [[NSMutableArray alloc]init];
    
    NSArray *cell_attributes = [NSArray arrayWithObjects:CELL_LEFT_TITLE,CELL_RIGHT_VALUE,CELL_RIGHT_UTIL,CELL_RIGHT_CONTROLTYPE,CELL_ACCESSORYTYPE,CELL_TAG, nil];
    NSMutableDictionary* dict = nil;
    
    NSArray *cell_values = [NSArray arrayWithObjects:[NSString stringWithCString:strMgr->GetDescript("STR_LOAN_AMOUNT").c_str() encoding:NSUTF8StringEncoding],@"aa",[NSString stringWithCString:strMgr->GetDescript("STR_TENTHOU").c_str() encoding:NSUTF8StringEncoding],@"WITH_TEXTFIELD",@"UITableViewCellAccessoryNone",@"0", nil];
    dict = [NSMutableDictionary dictionaryWithObjects:cell_values forKeys:cell_attributes];
    [nsma addObject:dict];
    
    cell_values = [NSArray arrayWithObjects:[NSString stringWithCString:strMgr->GetDescript("STR_LOAN_YEAR").c_str() encoding:NSUTF8StringEncoding],@"aa",[NSString stringWithCString:strMgr->GetDescript("STR_YEAR").c_str() encoding:NSUTF8StringEncoding],@"WITH_TEXTFIELD",@"UITableViewCellAccessoryNone",@"1", nil];
    dict = [NSMutableDictionary dictionaryWithObjects:cell_values forKeys:cell_attributes];
    [nsma addObject:dict];
    
    cell_values = [NSArray arrayWithObjects:[NSString stringWithCString:strMgr->GetDescript("STR_LOAN_INTEREST").c_str() encoding:NSUTF8StringEncoding],@"aa",[NSString stringWithCString:strMgr->GetDescript("STR_PERCENT").c_str() encoding:NSUTF8StringEncoding],@"WITH_TEXTFIELD",@"UITableViewCellAccessoryNone",@"2", nil];
    dict = [NSMutableDictionary dictionaryWithObjects:cell_values forKeys:cell_attributes];
    [nsma addObject:dict];
    
    cell_values = [NSArray arrayWithObjects:[NSString stringWithCString:strMgr->GetDescript("STR_PAMENT_PASSED_MONTH").c_str() encoding:NSUTF8StringEncoding],@"aa",[NSString stringWithCString:strMgr->GetDescript("STR_MONTH").c_str() encoding:NSUTF8StringEncoding],@"WITH_TEXTFIELD",@"UITableViewCellAccessoryNone",@"3", nil];
    dict = [NSMutableDictionary dictionaryWithObjects:cell_values forKeys:cell_attributes];
    [nsma addObject:dict];
    
    cell_values = [NSArray arrayWithObjects:[NSString stringWithCString:strMgr->GetDescript("STR_PERPAYMENT_TYPE").c_str() encoding:NSUTF8StringEncoding],[NSString stringWithCString:strMgr->GetDescript("STR_PERPAYMENT_PART").c_str() encoding:NSUTF8StringEncoding],@"",@"WITH_LABEL",@"UITableViewCellAccessoryDisclosureIndicator",@"4", nil];
    dict = [NSMutableDictionary dictionaryWithObjects:cell_values forKeys:cell_attributes];
    [nsma addObject:dict];
    
    cell_values = [NSArray arrayWithObjects:[NSString stringWithCString:strMgr->GetDescript("STR_PERPAYMENT_THE_MONTH").c_str() encoding:NSUTF8StringEncoding],@"aa",[NSString stringWithCString:strMgr->GetDescript("STR_TENTHOU").c_str() encoding:NSUTF8StringEncoding],@"WITH_TEXTFIELD",@"UITableViewCellAccessoryNone",@"5", nil];
    dict = [NSMutableDictionary dictionaryWithObjects:cell_values forKeys:cell_attributes];
    [nsma addObject:dict];
    
    cell_values = [NSArray arrayWithObjects:[NSString stringWithCString:strMgr->GetDescript("STR_PERPAYMENT_REDUCE_TYPE").c_str() encoding:NSUTF8StringEncoding],[NSString stringWithCString:strMgr->GetDescript("STR_PERPAYMENT_REDUCE_PERPAID").c_str() encoding:NSUTF8StringEncoding],@"",@"WITH_LABEL",@"UITableViewCellAccessoryDisclosureIndicator",@"6", nil];
    dict = [NSMutableDictionary dictionaryWithObjects:cell_values forKeys:cell_attributes];
    [nsma addObject:dict];
    
    NSMutableArray *pts = [NSMutableArray arrayWithObjects:[NSString stringWithCString:strMgr->GetDescript("STR_PERPAYMENT_PART").c_str() encoding:NSUTF8StringEncoding],[NSString stringWithCString:strMgr->GetDescript("STR_PERPAYMENT_ALL").c_str() encoding:NSUTF8StringEncoding], nil];
    NSMutableArray *prts = [NSMutableArray arrayWithObjects:[NSString stringWithCString:strMgr->GetDescript("STR_PERPAYMENT_REDUCE_PERPAID").c_str() encoding:NSUTF8StringEncoding],[NSString stringWithCString:strMgr->GetDescript("STR_PERPAYMENT_REDUCE_MONTHS").c_str() encoding:NSUTF8StringEncoding], nil];
    
    g_prepaymentViewController = [[PrepaymentViewController alloc] init:nsma withPreTypes:pts withPreReduceTypes:prts withStyle:UITableViewStylePlain];
}

void initEqPayment()
{
    g_EqInstalmentViewController = [[EqInstalmentViewController alloc] initWithNibName:nil bundle:nil];
    
    //初始化等额本金输入view
    std::vector<std::string> vec_eq_payment_label;
    vec_eq_payment_label.push_back(strMgr->GetDescript("STR_LOAN_AMOUNT"));
    vec_eq_payment_label.push_back(strMgr->GetDescript("STR_LOAN_YEAR"));
    vec_eq_payment_label.push_back(strMgr->GetDescript("STR_LOAN_INTEREST"));
    std::vector<std::string> vec_eq_payment_value(vec_eq_payment_label.size(),"");
    std::vector< std::vector<std::string> > vec_vec_eq_payment_label;
    vec_vec_eq_payment_label.push_back(vec_eq_payment_label);
    std::vector< std::vector<std::string> > vec_vec_eq_payment_value;
    vec_vec_eq_payment_value.push_back(vec_eq_payment_value);

    //初始化等额本金输出view
    std::vector<std::string> vec_eqpayout_label1;
    vec_eqpayout_label1.push_back(strMgr->GetDescript("STR_HOUSE_PRICE"));
    vec_eqpayout_label1.push_back(strMgr->GetDescript("STR_INITIAL_PAYMENT"));
    vec_eqpayout_label1.push_back(strMgr->GetDescript("STR_LOAN_AMOUNT"));
    vec_eqpayout_label1.push_back(strMgr->GetDescript("STR_PAYENT_AMOUNT"));
    vec_eqpayout_label1.push_back(strMgr->GetDescript("STR_INTERST_AMOUNT"));
    std::vector<std::string> vec_eqpayout_value1(vec_eqpayout_label1.size(),"");
    std::vector< std::vector<std::string> > vec_vec_eq_payment_label1;
    vec_vec_eq_payment_label1.push_back(vec_eqpayout_label1);
    std::vector< std::vector<std::string> > vec_vec_eq_payment_value1;
    vec_vec_eq_payment_value1.push_back(vec_eqpayout_value1);
    
    //vec_eqpayout_label.push_back(strMgr->GetDescript("STR_HOUSE_PRICE"));
    
    g_eqpayViewController = [[EqpaymentViewController alloc] initWithNibName:nil bundle:nil];
    
    g_eqpayInputViewController = [[OutputViewController alloc] init:UITableViewStyleGrouped withTexts:vec_vec_eq_payment_label withValues:vec_vec_eq_payment_value withCellType:WITH_TEXTFIELD];
    g_eqpayOutputViewController = [[OutputViewController alloc] init:UITableViewStyleGrouped withTexts:vec_vec_eq_payment_label1 withValues:vec_vec_eq_payment_value1 withCellType:WITH_LABEL];
    
    g_eqpayViewController.eqpayInputViewController = g_eqpayInputViewController;
    g_eqpayViewController.eqpayOutputViewController = g_eqpayOutputViewController;
}

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize splitViewController = _splitViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    init_map_func();
    init_string();
    initEqPayment();
    
    initPrepaymentViewController();
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController_iPhone" bundle:nil];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
        self.window.rootViewController = self.navigationController;
    } else {
        MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController_iPad" bundle:nil];
        UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
        
        DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPad" bundle:nil];
        UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    	
        self.splitViewController = [[UISplitViewController alloc] init];
        self.splitViewController.delegate = detailViewController;
        self.splitViewController.viewControllers = [NSArray arrayWithObjects:masterNavigationController, detailNavigationController, nil];
        
        self.window.rootViewController = self.splitViewController;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
