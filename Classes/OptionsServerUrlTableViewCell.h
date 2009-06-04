//
//  ProjectDetailsTableViewCell.h
//  CCPhone
//
//  Created by Alex Hung on 6/28/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCServer.h"

@interface OptionsServerUrlTableViewCell : UITableViewCell<UITextFieldDelegate> {
	
	NSString *title;
	NSString *content;
	UILabel *titleLabel;
	UITextField *contentTextField;

	CCServer *ccServer;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) CCServer *ccServer;

@end
