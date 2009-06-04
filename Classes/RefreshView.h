//
//  RefreshView.h
//  CCPhone
//
//  Created by Alex Hung on 12/2/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RefreshView : UIView {
	
	UIActivityIndicatorView *activityIndicator;
	UILabel *label;
}

- (void)startRefreshing;
- (void)stopRefreshing;

@end
