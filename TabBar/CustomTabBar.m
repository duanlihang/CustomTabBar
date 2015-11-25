//
//  CustomTabBar.m
//  CustomTabBar
//
//  Created by 段立航 on 15/9/23.
//  Copyright © 2015年 Duan. All rights reserved.
//

#import "CustomTabBar.h"
#import "UIBadgeView.h"

#define ScreenWidth     CGRectGetWidth([UIScreen mainScreen].applicationFrame)

@implementation CustomTabBar

- (instancetype)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray titleArray:(NSArray *)titleArray widthArray:(NSArray *)widthArray
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.backgroundView];
        
        self.buttons = [[NSMutableArray alloc] init];
        self.badges = [[NSMutableArray alloc] init];
        
        UIButton *btn;
        float xOffset = 0;
        for (int i = 0; i < imageArray.count; i++)
        {
            NSNumber *num = [widthArray objectAtIndex:i];
            CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) *num.floatValue;
            
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            if (i == 2)
            {
                btn.frame = CGRectMake(xOffset, -15, width, 66);
                if (ScreenWidth == 414)
                {
                    btn.frame = CGRectMake(xOffset - 1, -15, width, 66);
                }
            }else
            {
                btn.frame = CGRectMake(xOffset, 0, width, frame.size.height);
            }

            [btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
            [btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
            [btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Seleted"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttons addObject:btn];
            [self addSubview:btn];
            
            
            if (i == 0)
            {
                UIBadgeView *theBadge = [[UIBadgeView alloc] initWithFrame:CGRectMake(width * i+width/2.0+6, 5, 20, 20)];
                [theBadge setBadgeColor:[UIColor colorWithRed:255.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.75f]];
                
                [self.badges addObject:theBadge];
                [self addSubview:theBadge];
                [theBadge setHidden:YES];
                
            }
            
            xOffset +=width;

            
            
        }
        
        
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)img
{
    [self.backgroundView setImage:img];
}
- (void)tabBarButtonClicked:(id)sender
{
    UIButton *btn = sender;
    [self selectTabBarAtIndex:btn.tag];
    NSLog(@"Select index: %ld",(long)btn.tag);
    if ([self.delegate respondsToSelector:@selector(tabBar:didselectIndex:)])
    {
        [self.delegate tabBar:self didselectIndex:btn.tag];
    }
}
- (void)selectTabBarAtIndex:(NSInteger)index
{
    for (int i = 0; i < [self.buttons count]; i++)
    {
        if(i != index)
        {
            UIButton *b = [self.buttons objectAtIndex:i];
            b.selected = NO;
            b.userInteractionEnabled = YES;
        }
        else
        {
            UIButton *b = [self.buttons objectAtIndex:i];
            b.selected = YES;
            b.userInteractionEnabled = NO;
        }
        
    }
}
- (void)setBadges:(NSString *)str index:(int)theIndex
{
    UIBadgeView *theBadge = [self.badges objectAtIndex:theIndex];
    if(str && ![str isEqualToString:@""])
    {
        [theBadge setHidden:NO];
        [theBadge.textLabel setText:str];
        [theBadge sizeToFit];
    }
    else
    {
        [theBadge setHidden:YES];
    }
}
@end
