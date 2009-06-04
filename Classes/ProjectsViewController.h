//
//  ProjectsViewController.h
//  CCPhone
//
//  Created by Alex Hung on 6/21/08.
//  Copyright ThoughtWorks 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCServer.h"
#import "RefreshView.h"
#import "ProjectTableViewCell.h"
#import "StatusMessageView.h"

@interface ProjectsViewController : UITableViewController {
	
	RefreshView *refreshView;
	StatusMessageView *statusMessageView;
	
	CCServer *ccServer;
}

- (void)fetchProjects:(id)sender;
- (void)showOptions:(id)sender;
- (void)startRefreshing;
- (void)stopRefreshing;
- (void)showFetchProjectError:(NSString *)message;
- (void)setAppBadge:(int)failedBuilds;
- (void)refreshView;
- (ProjectTableViewCell *)getProjectTableViewCell:(UITableView *)tableView atRowIndex:(NSUInteger)rowIndex;

@property (nonatomic, retain) CCServer *ccServer;

@end
