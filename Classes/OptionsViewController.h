//
//  OptionsViewController.h
//  CCPhone
//
//  Created by Alex Hung on 12/6/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPhoneAppDelegate.h"

@interface OptionsViewController : UITableViewController<UINavigationControllerDelegate> {

	CCServer *ccServer;
	NSObject *refreshDelegate;
}

- (void)dismissView:(id)sender;

@property (nonatomic, retain) CCServer *ccServer;
@property(nonatomic, retain) NSObject *refreshDelegate;

@end
