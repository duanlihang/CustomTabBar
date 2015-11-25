//
//  CustomTabBarController.m
//  CustomTabBar
//
//  Created by 段立航 on 15/9/23.
//  Copyright © 2015年 Duan. All rights reserved.
//

#import "CustomTabBarController.h"
//#import "LoginViewController.h"


#define TABBAR_HEIGHT 49.0f
#define ScreenWidth     CGRectGetWidth([UIScreen mainScreen].applicationFrame)



@interface CustomTabBarController ()
{
    UIButton *_bigButton;
}
@end

@implementation CustomTabBarController
- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr titleArray:(NSArray *)titleArray  widthArr:(NSArray *)widthArr
{
    self = [super init];
    if (self != nil)
    {
        self.viewControllers = [NSMutableArray arrayWithArray:vcs];
        CGRect rc = [[UIScreen mainScreen] applicationFrame];
        
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (version >= 7.0)
        {
            rc = CGRectMake(0, 0, rc.size.width, rc.size.height+20);
        }
        else
        {
        }
        _containerView = [[UIView alloc] initWithFrame:rc];
        _containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _transitionView = [[UIView alloc] initWithFrame:_containerView.bounds];
        _transitionView.backgroundColor =  [UIColor groupTableViewBackgroundColor];
        
        _tabBar = [[CustomTabBar alloc] initWithFrame:CGRectMake(0, self.containerView.frame.size.height - TABBAR_HEIGHT, CGRectGetWidth([UIScreen mainScreen].applicationFrame), TABBAR_HEIGHT) buttonImages:arr titleArray:titleArray widthArray:widthArr];
        self.tabBar.delegate = self;
        
        
        int xOffset = 0;
        for (int i = 0; i < [arr count]; i++)
        {
            NSNumber *num = [widthArr objectAtIndex:i];
            CGFloat width = CGRectGetWidth([UIScreen mainScreen].applicationFrame) * num.floatValue;
            
//            if (i == 2)
//            {
//                
//                _bigButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                _bigButton.frame = CGRectMake(self.view.frame.size.width/2 - 25, rc.size.height - 55, 50, 50);
//                [_bigButton setImage:[[arr objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
//                [_bigButton setImage:[[arr objectAtIndex:i] objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
//                [_bigButton setImage:[[arr objectAtIndex:i] objectForKey:@"Seleted"] forState:UIControlStateSelected];
//                
//            }
            xOffset+=width;
        }

    }
    return self;
}

- (void)loadView
{
    [super loadView];
    

    [_containerView addSubview:_transitionView];
    [_containerView addSubview:_tabBar];
    
    
    _line1 = [[UIView alloc]initWithFrame:CGRectMake(0, _containerView.frame.size.height - TABBAR_HEIGHT, (ScreenWidth/2) - 25 - 2.5, 0.5)];
    _line1.backgroundColor = [self colorFromHexRGB:@"adaeb0"];
    
    _line2 = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/2) + 25 + 1.3, _containerView.frame.size.height - TABBAR_HEIGHT, (ScreenWidth/2) - 25, 0.5)];
    _line2.backgroundColor = [self colorFromHexRGB:@"adaeb0"];
    
    [_containerView addSubview:_line1];
    [_containerView addSubview:_line2];
    
    [_containerView addSubview:_bigButton];
    self.view = _containerView;
}
/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
- (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    NSString *cString = [[inColorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if (cString.length < 6)
    {
        return [UIColor blackColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if (cString.length != 6)
    {
        return [UIColor blackColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //   OutLog(@"r=%f,g=%f,b=%f",(float)r,(float)g,(float)b);
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.selectedIndex = 2;
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[self selectedViewController] viewDidAppear:animated];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.tabBar = nil;
    self.viewControllers = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ClikedShopCar" object:nil];
}

- (void)setNav:(UINavigationController *)nav
{
    _nav = nav;
}

#pragma mark - instant methods


- (UIViewController *)selectedViewController
{
    return [_viewControllers objectAtIndex:_selectedIndex];
}

-(void)setSelectedIndex:(NSUInteger)index
{
    [self displayViewAtIndex:index];
    
    [_tabBar selectTabBarAtIndex:index];
}




#pragma mark - Private methods
- (void)displayViewAtIndex:(NSUInteger)index
{
    
    if(index != 0 && index!=1)
    {
        NSString *tabBarSelectedIndex = [NSString stringWithFormat:@"%zi",index];
        [[NSUserDefaults standardUserDefaults] setObject:tabBarSelectedIndex forKey:@"tabBarSelectedIndex"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    
    UIViewController *oldViewController = [_viewControllers objectAtIndex:_selectedIndex];
    _selectedIndex = index;
    UIViewController *newViewController = [_viewControllers objectAtIndex:_selectedIndex];
    
    if(newViewController != oldViewController)
    {
        [oldViewController viewWillDisappear:NO];
        [oldViewController.view setHidden:YES];
        [[self selectedViewController] viewWillAppear:NO];
        [[self selectedViewController].view setHidden:NO];
        
    }
    
    UIViewController *selectedVC = [self selectedViewController];
    
    selectedVC.view.frame = _transitionView.frame;
    if ([selectedVC.view isDescendantOfView:_transitionView]) //判断view是不是指定视图的子视图
    {
        [_transitionView bringSubviewToFront:selectedVC.view];
    }
    else
    {
        [_transitionView addSubview:selectedVC.view];
    }
    
    
    
    if(newViewController != oldViewController)
    {
        [oldViewController viewDidDisappear:NO];
        [[self selectedViewController] viewDidAppear:NO];
    }
}

#pragma mark -
#pragma mark tabBar delegates
- (void)tabBar:(CustomTabBar *)tabBar didselectIndex:(NSInteger)index;
{
    if (self.selectedIndex == index)
    {
        return;
    }
    else
    {
        if (index == 0 || index == 1)
        {
//            if(!APPDEL.loginOK){
//                LoginViewController *vc=[[LoginViewController alloc] initWithHasCancel:YES state:kToPreTab];
//                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//                [self  presentViewController:nav animated:YES completion:nil];
//
//                NSString *theIndex = [[NSUserDefaults standardUserDefaults] objectForKey:@"tabBarSelectedIndex"];
//                self.selectedIndex = [theIndex integerValue];
//                
//            }else
            {
                [self displayViewAtIndex:index];
            }
        }else
        {
            [self displayViewAtIndex:index];
        }
        
        
    }
}

- (void)setBadge:(NSString *)str index:(int)theIndex
{
    [self.tabBar setBadges:str index:theIndex];
}

-(void)hideTabBar:(BOOL)isHide
{
    [self.tabBar setHidden:isHide];
    [_line1 setHidden:isHide];
    [_line2 setHidden:isHide];

}

@end
