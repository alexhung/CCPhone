//
//  ProjectTableViewCell.h
//  CCPhone
//
//  Created by ahung on 6/27/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCProject.h"

@interface ProjectTableViewCell : UITableViewCell {

	UIView *backgroundView;
	UIImageView *buildStatusImageView;
	UILabel *projectNameLabel;
	UILabel *lastBuildTimeLabel;
}

- (UIImage *)getBuildStatusImage:(NSString *)activity lastBuildStatus:(NSString *)lastBuildStatus;

@property (nonatomic, retain) CCProject *project;

@end
