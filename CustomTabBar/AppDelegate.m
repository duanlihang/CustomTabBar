//
//  AppDelegate.m
//  CustomTabBar
//
//  Created by 段立航 on 15/9/23.
//  Copyright © 2015年 Duan. All rights reserved.
//

#import "AppDelegate.h"



#import "FirstController.h"
#import "SecondController.h"
#import "ThirdController.h"
#import "FourthViewController.h"
#import "FifthController.h"


#define ScreenWidth     CGRectGetWidth([UIScreen mainScreen].applicationFrame)


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [self jumpToTabbarController];

    
    return YES;
}
- (void)jumpToTabbarController
{
    
    FirstController *vc1 = [[FirstController alloc] init];
    SecondController *vc2 = [[SecondController alloc] init];
    ThirdController *vc3 = [[ThirdController alloc] init];
    FourthViewController*vc4 = [[FourthViewController alloc] init];
    FifthController *vc5 = [[FifthController alloc] init];
    vc1.navigationItem.title = @"界面一";
    vc2.navigationItem.title = @"界面二";
    vc3.navigationItem.title = @"界面三";
    vc4.navigationItem.title = @"界面四";
    vc5.navigationItem.title = @"界面五";
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    
    NSArray *ctrlArr = @[nav1,nav2,nav3,nav4,nav5];
    
    NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:5];
    
    
    [imgDic setObject:[UIImage imageNamed:@"tab_icon1"] forKey:@"Default"];
    [imgDic setObject:[UIImage imageNamed:@"tab_icon1_sel"] forKey:@"Highlighted"];
    [imgDic setObject:[UIImage imageNamed:@"tab_icon1_sel"] forKey:@"Seleted"];
    
    NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic2 setObject:[UIImage imageNamed:@"tab_icon2"] forKey:@"Default"];
    [imgDic2 setObject:[UIImage imageNamed:@"tab_icon2_sel"] forKey:@"Highlighted"];
    [imgDic2 setObject:[UIImage imageNamed:@"tab_icon2_sel"] forKey:@"Seleted"];
    
    NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic3 setObject:[UIImage imageNamed:@"tab_icon3"] forKey:@"Default"];
    [imgDic3 setObject:[UIImage imageNamed:@"tab_icon3_sel"] forKey:@"Highlighted"];
    [imgDic3 setObject:[UIImage imageNamed:@"tab_icon3_sel"] forKey:@"Seleted"];
    
    NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic4 setObject:[UIImage imageNamed:@"tab_icon4"] forKey:@"Default"];
    [imgDic4 setObject:[UIImage imageNamed:@"tab_icon4_sel"] forKey:@"Highlighted"];
    [imgDic4 setObject:[UIImage imageNamed:@"tab_icon4_sel"] forKey:@"Seleted"];
    
    NSMutableDictionary *imgDic5 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic5 setObject:[UIImage imageNamed:@"tab_icon5"] forKey:@"Default"];
    [imgDic5 setObject:[UIImage imageNamed:@"tab_icon5_sel"] forKey:@"Highlighted"];
    [imgDic5 setObject:[UIImage imageNamed:@"tab_icon5_sel"] forKey:@"Seleted"];
    
    
    NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic2,imgDic3,imgDic4,imgDic5,nil];
    
    NSArray *widthArr = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.19],[NSNumber numberWithFloat:0.19],[NSNumber numberWithFloat:0.24],[NSNumber numberWithFloat:0.19],[NSNumber numberWithFloat:0.19],nil];
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"界面一",@"界面二",@"界面三",@"界面四",@"界面五",nil];
    self.customTabBarController = [[CustomTabBarController alloc] initWithViewControllers:ctrlArr imageArray:imgArr titleArray:titleArray widthArr:widthArr];
    [self.customTabBarController.tabBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(ScreenWidth, 49)]];
    // 设置消息数量
        [self.customTabBarController setBadge:@"100" index:0];
    
    self.customTabBarController.selectedIndex = 2;
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.customTabBarController;
    
}
// 隐藏tabbar
-(void)hideTabBar:(BOOL)isHide
{
    [self.customTabBarController hideTabBar:isHide];
}
- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
