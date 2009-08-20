//
//  RefreshView.m
//  CCPhone
//
//  Created by Alex Hung on 12/2/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import "RefreshView.h"


@implementation RefreshView


- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.hidden = YES;
		self.alpha = 0.8;
		
		activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		[self addSubview:activityIndicator];
		
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.text = @"Loading...";
		label.font = [UIFont systemFontOfSize:16];
		label.textAlignment = UITextAlignmentCenter;
		label.textColor = [UIColor whiteColor];
		label.backgroundColor = [UIColor clearColor];
		[self addSubview:label];
	}
	return self;
}

- (void)layoutSubviews {	
  [super layoutSubviews];
	
	UIApplication *app = [UIApplication sharedApplication];
	UIWindow *window = app.keyWindow;
	
	CGPoint centerPoint = [window convertPoint:window.center toView:self];
	activityIndicator.frame = CGRectMake(self.center.x - 60, centerPoint.y, 20, 20);
	label.frame = CGRectMake(self.center.x - 40, centerPoint.y, 100, 20);
}

- (void)drawRect:(CGRect)rect {
	// Drawing code
	UIColor *backgroundColor = self.backgroundColor;
	if (!backgroundColor) {
		backgroundColor = [UIColor blackColor];
	}
	
	CGColorRef color = CGColorCreateCopyWithAlpha(backgroundColor.CGColor, self.alpha);	
	[UIColor colorWithCGColor:color].set;
	UIRectFill(self.frame);
	CGColorRelease(color);
}

- (void)startRefreshing {
	self.hidden = NO;
	[activityIndicator startAnimating];
}

- (void)stopRefreshing {
	self.hidden = YES;
	[activityIndicator stopAnimating];
}

- (void)dealloc {
	[activityIndicator release];
	[label release];
	[super dealloc];	
}


@end
