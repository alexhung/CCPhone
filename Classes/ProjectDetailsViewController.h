//
//  ProjectDetailsViewController.h
//  CCPhone
//
//  Created by ahung on 6/26/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCProject.h"
#import "CCPhoneAppDelegate.h"

@interface ProjectDetailsViewController : UITableViewController <UIActionSheetDelegate> {

	CCProject *project;
}

- (void)forceBuild;
- (void)viewLog;

- (UITableViewCell *)getViewLogTableViewCell:(UITableView *)tableView rowIndex:(NSUInteger)rowIndex;
- (UITableViewCell *)getForceBuildTableViewCell:(UITableView *)tableView rowIndex:(NSUInteger)rowIndex;
- (UITableViewCell *)getProjectPropertiesTableViewCell:(UITableView *)tableView rowIndex:(NSUInteger)rowIndex;

@property (nonatomic, retain) CCProject *project;

@end
