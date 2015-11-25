//
//  ThirdController.m
//  CustomTabBar
//
//  Created by 段立航 on 15/10/21.
//  Copyright © 2015年 Duan. All rights reserved.
//

#import "ThirdController.h"
#import "PushController.h"

#import "AppDelegate.h"

#define APPDEL ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface ThirdController ()

@end

@implementation ThirdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"界面三";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 130, self.view.frame.size.width - 40, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Push" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
}
- (void)btnClick
{
    PushController *vc = [[PushController alloc] init];
    // 隐藏tabbar
    [APPDEL hideTabBar:YES];
    [self.navigationController pushViewController:vc animated:YES];
}
// 来到主页面设置tabbar显示
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APPDEL hideTabBar:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
