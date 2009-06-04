//
//  BuildDetailsViewController.h
//  CCPhone
//
//  Created by ahung on 8/2/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BuildDetailsViewController : UIViewController <UIWebViewDelegate> {
	UIWebView *webView;
	
	UIBarButtonItem *refreshButton;
	UIBarButtonItem *activityButton;
	
	NSURL *url;
}

- (void)reload:(id)sender;
- (void)startActivityAnimation;
- (void)stopActivityAnimation;

@property (nonatomic, retain) NSURL *url;

@end
