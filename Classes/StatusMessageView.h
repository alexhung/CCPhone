//
//  NoProjectView.h
//  CCPhone
//
//  Created by Alex Hung on 1/8/09.
//  Copyright 2009 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StatusMessageView : UIView {
	UILabel *label;
}

- (void)showView;
- (void)hideView;

@property (nonatomic, retain) NSString *text;

@end
