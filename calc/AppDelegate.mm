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

std::vector< Functions > g_type_func;

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

EqInstalmentViewController *g_EqInstalmentViewController;
OutputViewController *g_eqInputViewController;
OutputViewController *g_preOutputViewController;

OutputViewController *g_eqpayInputViewController;
OutputViewController *g_eqpayOutputViewController;
EqpaymentViewController *g_preViewController;

void init()
{
    g_EqInstalmentViewController = [[EqInstalmentViewController alloc] initWithNibName:nil bundle:nil];
    
    //初始化等额本金输入view
    StringMgr* strMgr = StringMgr::GetStringMgr();
    std::vector<std::string> vec_eq_payment_label;
    vec_eq_payment_label.push_back(strMgr->GetDescript("STR_LOAN_AMOUNT"));
    vec_eq_payment_label.push_back(strMgr->GetDescript("STR_LOAN_YEAR"));
    vec_eq_payment_label.push_back(strMgr->GetDescript("STR_LOAN_INTEREST"));
    std::vector<std::string> vec_eq_payment_value;
    vec_eq_payment_value.push_back("");
    vec_eq_payment_value.push_back("");
    vec_eq_payment_value.push_back("");
    
    g_eqpayInputViewController = [[OutputViewController alloc] init:UITableViewStyleGrouped withTexts:vec_eq_payment_label withValues:vec_eq_payment_value withCellType:WITH_TEXTFIELD];
    g_preViewController = [[EqpaymentViewController alloc] initWithNibName:nil bundle:nil];
    g_preViewController.eqInputViewController = g_eqpayInputViewController;
}

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize splitViewController = _splitViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    init_map_func();
    init_string();
    init();
    
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
