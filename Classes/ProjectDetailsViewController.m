//
//  ProjectDetailsViewController.m
//  CCPhone
//
//  Created by ahung on 6/26/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import "ProjectDetailsViewController.h"
#import "ProjectDetailsTableViewCell.h"
#import "BuildDetailsViewController.h"

@implementation ProjectDetailsViewController

@synthesize project;

- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {

	}
	return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Details";
	self.tableView.sectionHeaderHeight = SETTING_HEADER_HEIGHT;
	self.view.backgroundColor = [CCPhoneAppDelegate darkGrey];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 6, SETTING_HEADER_ROW_WIDTH, SETTING_HEADER_HEIGHT)];
	headerView.backgroundColor = [UIColor clearColor];
	
	UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 6, SETTING_HEADER_ROW_WIDTH, SETTING_HEADER_HEIGHT)];
	headerLabel.font = [UIFont boldSystemFontOfSize:SETTING_HEADER_FONT_SIZE];
	headerLabel.text = section == 0 ? project.name : @"";
	headerLabel.textColor = [UIColor lightGrayColor];
	headerLabel.backgroundColor = [UIColor clearColor];
	
	[headerView addSubview:headerLabel];
	return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return section == 0 ? 4 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSUInteger sectionIndex = [indexPath section];
	NSUInteger rowIndex = [indexPath row];
	
	if (sectionIndex == 0) {
		return [self getProjectPropertiesTableViewCell:tableView rowIndex:rowIndex];
	}
	if (sectionIndex == 1) {
		return [self getViewLogTableViewCell:tableView rowIndex:rowIndex];
	}
	else {
		return [self getForceBuildTableViewCell:tableView rowIndex:rowIndex];
	}
}

- (UITableViewCell *)getProjectPropertiesTableViewCell:(UITableView *)tableView rowIndex:(NSUInteger)rowIndex {

	NSString *cellIdentifier = @"projectDetailCell";
	
	ProjectDetailsTableViewCell *cell = (ProjectDetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[[ProjectDetailsTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
	}
	
	switch (rowIndex) {
		case 0:
			cell.title = @"last build status";
			cell.content = project.lastBuildStatus;			
			break;
			
		case 1:
			cell.title = @"last build time";
			cell.content = [CCProject convertDateToString:project.lastBuildTime];			
			break;
			
		case 2:
			cell.title = @"last build label";
			cell.content = project.lastBuildLabel;			
			break;
			
		case 3:
			cell.title = @"activity";
			cell.content = project.activity;			
			break;
			
		default:
			break;
	}
	
	return cell;	
}

- (UITableViewCell *)getForceBuildTableViewCell:(UITableView *)tableView rowIndex:(NSUInteger)rowIndex {

	NSString *cellIdentifier = @"ForceBuildIdentifier";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
		
		cell.text = @"Force Build";
		cell.textAlignment = UITextAlignmentCenter;
		cell.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
		cell.textColor = [UIColor colorWithRed:0.384 green:0.459 blue:0.612 alpha:1.0];
	}

	return cell;
}

- (UITableViewCell *)getViewLogTableViewCell:(UITableView *)tableView rowIndex:(NSUInteger)rowIndex {
	
	NSString *cellIdentifier = @"ViewLogIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
		
		cell.text = @"View Last Build Log";
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.textAlignment = UITextAlignmentCenter;
		cell.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
		cell.textColor = [UIColor colorWithRed:0.384 green:0.459 blue:0.612 alpha:1.0];
	}
	
	return cell;
}
		
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath {
    
	NSUInteger sectionIndex = newIndexPath.section;
	
	if (sectionIndex == 1) {
		[self viewLog];
	}
	/*
	else {
		[self forceBuild];
	}
	 */
	
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (void)viewLog {
	
	BuildDetailsViewController *buildDetailsViewController = [[BuildDetailsViewController alloc] init];
	buildDetailsViewController.url = [NSURL URLWithString:project.webUrl];
	
	// Set the stories controller's inspected item to the currently-selected item
	[[self navigationController] pushViewController:buildDetailsViewController animated:YES];
	[buildDetailsViewController release];
}

- (void)forceBuild {
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure you want to force a build?"
															 delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view];
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	/*if (buttonIndex == 0) {
		[project sendForceBuildWebRequest];
	}*/
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Force Build Request" message:@"Sent!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[[self navigationController] popToRootViewControllerAnimated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	return YES;
}

- (void)dealloc {
	[super dealloc];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


@end

