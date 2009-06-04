//
//  ProjectDetailsTableViewCell.h
//  CCPhone
//
//  Created by Alex Hung on 6/28/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProjectDetailsTableViewCell : UITableViewCell {
	
	NSString *title;
	NSString *content;
	UILabel *titleLabel;
	UILabel *contentLabel;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *content;

@end
