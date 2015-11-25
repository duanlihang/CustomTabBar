//
//  AppDelegate.h
//  CustomTabBar
//
//  Created by 段立航 on 15/9/23.
//  Copyright © 2015年 Duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBarController.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CustomTabBarController *customTabBarController;

// 隐藏tabbar
-(void)hideTabBar:(BOOL)isHide;


@end

