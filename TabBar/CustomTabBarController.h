//
//  CustomTabBarController.h
//  CustomTabBar
//
//  Created by 段立航 on 15/9/23.
//  Copyright © 2015年 Duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBar.h"


@interface CustomTabBarController : UIViewController<CustomTabBarDelegate>


@property (nonatomic, strong) CustomTabBar *tabBar;
@property (nonatomic, strong) UIView      *containerView;
@property (nonatomic, strong) UIView		*transitionView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic,strong) UINavigationController *nav;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;


- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr titleArray:(NSArray *)titleArray widthArr:(NSArray *)widthArr;
-(void)hideTabBar:(BOOL)isHide;
- (void)setBadge:(NSString *)str index:(int)theIndex;



@end
