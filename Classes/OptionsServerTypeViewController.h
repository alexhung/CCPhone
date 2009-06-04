//
//  OptionsServerTypeViewController.h
//  CCPhone
//
//  Created by Alex Hung on 12/7/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCServer.h"

@interface OptionsServerTypeViewController : UITableViewController {

	CCServer *ccServer;
}

@property (nonatomic, retain) CCServer *ccServer;

@end
