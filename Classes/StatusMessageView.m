//
//  NoProjectView.m
//  CCPhone
//
//  Created by Alex Hung on 1/8/09.
//  Copyright 2009 ThoughtWorks. All rights reserved.
//

#import "StatusMessageView.h"
#import "CCPhoneAppDelegate.h"

@implementation StatusMessageView

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.hidden = YES;
		self.backgroundColor = [CCPhoneAppDelegate darkGrey];
		
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.textAlignment = UITextAlignmentCenter;
		label.textColor = [UIColor whiteColor];
		label.backgroundColor = [UIColor clearColor];
		label.numberOfLines = 2;
		[self addSubview:label];
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	UIApplication *app = [UIApplication sharedApplication];
	UIWindow *window = app.keyWindow;
	
	CGPoint centerPoint = [window convertPoint:window.center toView:self];
	
	label.frame = CGRectMake(self.bounds.origin.x, centerPoint.y, self.bounds.size.width, 40);
}

- (void)drawRect:(CGRect)rect {
	UIColor *backgroundColor = self.backgroundColor;
	if (!backgroundColor) {
		backgroundColor = [UIColor blackColor];
	}
	
	CGColorRef color = CGColorCreateCopyWithAlpha(backgroundColor.CGColor, self.alpha);
	
	[UIColor colorWithCGColor:color].set;
	
	UIRectFill(self.frame);
	
	CGColorRelease(color);
}

- (void)showView {
	self.hidden = NO;
}

- (void)hideView {
	self.hidden = YES;
}

- (void)setText:(NSString *)newText {
	label.text = newText;
}

- (NSString *)text {
	return label.text;
}

- (void)dealloc {
	[label release];
	[super dealloc];
}


@end
