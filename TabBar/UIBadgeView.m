//
//  BadgeView.h
//  BadgeView
//
//  Created by 段立航 on 15/9/23.
//  Copyright © 2015年 Duan. All rights reserved.
//

#import "UIBadgeView.h"


@implementation UIBadgeView


@synthesize textLabel = _textLabel;
@synthesize badgeColor = _badgeColor;
@synthesize cornerRadius = _cornerRadius;


#pragma mark -
#pragma mark Initialization

- (id)initWithFrame:(CGRect)rect {
	if ((self = [super initWithFrame:rect])) {
        self.opaque = YES;
		self.backgroundColor = [UIColor clearColor];
        self.cornerRadius = 10.0f;
        self.badgeColor = [[self class] defaultBadgeColor];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.text = @"0";
        _textLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor whiteColor];
	}
	return self;
}



#pragma mark - Class Methods

+ (UIColor *)defaultBadgeColor {
	return [UIColor colorWithRed:0.541f green:0.596f blue:0.694f alpha:1.0f];
}


#pragma mark -
#pragma mark Accessors

- (void)setBadgeColor:(UIColor *)badgeColor {

	_badgeColor = badgeColor;
	
	[self setNeedsDisplay];
}


- (void)setCornerRadius:(CGFloat)cornerRadius {
	_cornerRadius = cornerRadius;
	
	[self setNeedsDisplay];
}


#pragma mark -

-(void)DrawRoundedRect:(CGContextRef) context rect:(CGRect) rect radius:(CGFloat) radius
{
    CGPoint min = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPoint mid = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGPoint max = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    CGContextMoveToPoint(context, min.x, mid.y);
    CGContextAddArcToPoint(context, min.x, min.y, mid.x, min.y, radius);
    CGContextAddArcToPoint(context, max.x, min.y, max.x, mid.y, radius);
    CGContextAddArcToPoint(context, max.x, max.y, mid.x, max.y, radius);
    CGContextAddArcToPoint(context, min.x, max.y, min.x, mid.y, radius);
    
    CGContextClosePath(context);
    CGContextFillPath(context);
}


- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGSize size = self.frame.size;
	CGSize badgeSize = [self sizeThatFits:size];
	badgeSize.height = fminf(badgeSize.height, size.height);
	
	CGFloat x = 0.0f;
    x = roundf((size.width - badgeSize.width) / 2.0f);
	
	CGRect badgeRect = CGRectMake(x, roundf((size.height - badgeSize.height) / 2.0f), badgeSize.width, badgeSize.height);
	
	if (_badgeColor) {
		[_badgeColor set];
        [self DrawRoundedRect:context rect:badgeRect radius:_cornerRadius];
	}
	
	[_textLabel drawTextInRect:badgeRect];
}


- (CGSize)sizeThatFits:(CGSize)size {
	CGSize textSize = [_textLabel sizeThatFits:self.bounds.size];
	return CGSizeMake(fmaxf(textSize.width + 8.0f, 20.0f), textSize.height + 6.0f);
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
	[super willMoveToSuperview:newSuperview];
	
	if (newSuperview) {
		[_textLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
		self.hidden = ([_textLabel.text length] == 0);
	} else {
		[_textLabel removeObserver:self forKeyPath:@"text"];
	}
}


#pragma mark - KVO Notifications

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if (object == _textLabel && [keyPath isEqualToString:@"text"]) {
		NSString *text = [change objectForKey:NSKeyValueChangeNewKey];
		if ([text isEqual:[NSNull null]]) {
			text = nil;
		}
		self.hidden = ([text length] == 0);
		
		if (!self.hidden) {
			[self setNeedsDisplay];
		}
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}


@end
