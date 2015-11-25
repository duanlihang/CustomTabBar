//
//  CustomTabBar.h
//  CustomTabBar
//
//  Created by 段立航 on 15/9/23.
//  Copyright © 2015年 Duan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTabBar;

@protocol CustomTabBarDelegate <NSObject>

- (void)tabBar:(CustomTabBar *)tabBar didselectIndex:(NSInteger)index;

@end

@interface CustomTabBar : UIView

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *badges;

@property (nonatomic, assign) id<CustomTabBarDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray titleArray:(NSArray *)titleArray widthArray:(NSArray *)widthArray;
- (void)selectTabBarAtIndex:(NSInteger)index;
- (void)setBackgroundImage:(UIImage *)image;
- (void)setBadges:(NSString *)str index:(int)theIndex;

@end
