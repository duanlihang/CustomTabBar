//
//  BadgeView.h
//  BadgeView
//
//  Created by 段立航 on 15/9/23.
//  Copyright © 2015年 Duan. All rights reserved.
//

/**
 * Provides a simple Badge view to use along with the class LSTabControl.
 * The badge background is rendered with Core Graphics.
 */

#import <UIKit/UIKit.h>

@interface UIBadgeView : UIView

/**
 * The badge text label.
 */
@property (nonatomic, strong, readonly) UILabel *textLabel;

/**
 * The badge's background color.
 * The default value of this property is grayish blue
 *
 * @see defaultBadgeColor
 */
@property (nonatomic, strong) UIColor *badgeColor;

/**
 * The corner radius used when rendering the rounded rect outline.
 * The default value of this property is 12
 */
@property (nonatomic, assign) CGFloat cornerRadius;


/**
 * The default badge color.
 */
+ (UIColor *)defaultBadgeColor;


@end