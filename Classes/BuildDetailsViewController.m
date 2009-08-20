//
//  BuildDetailsViewController.m
//  CCPhone
//
//  Created by ahung on 8/2/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import "BuildDetailsViewController.h"


@implementation BuildDetailsViewController

@synthesize url;

- (id)init {
	if (self = [super init]) {
		self.title = @"Build Log";
	}
	return self;
}

- (void)viewDidLoad {
	webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
	webView.backgroundColor = [UIColor whiteColor];
	webView.scalesPageToFit = YES;
	webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	webView.delegate = self;
	[self.view addSubview:webView];
	
	refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload:)];
	self.navigationItem.rightBarButtonItem = refreshButton;
	
	UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	activityButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
	[activityIndicator release];
	
	[self startActivityAnimation];
	[webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)reload:(id)sender {
	[self startActivityAnimation];
	[webView reload];
}

- (void)startActivityAnimation {
	self.navigationItem.rightBarButtonItem = activityButton;
	UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)activityButton.customView;
	[activityIndicator startAnimating];
}

- (void)stopActivityAnimation {
	UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)activityButton.customView;
	[activityIndicator stopAnimating];
	self.navigationItem.rightBarButtonItem = refreshButton;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self stopActivityAnimation];
}

- (void)webView:(UIWebView *)aWebView didFailLoadWithError:(NSError *)error {
    [self stopActivityAnimation];
	
    NSString* errorString = [NSString stringWithFormat:
                             @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
                             error.localizedDescription];
    [aWebView loadHTMLString:errorString baseURL:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
}

- (void)dealloc {
	[webView release];
	[refreshButton release];
	[activityButton release];
	[url release];
	[super dealloc];
}


@end
