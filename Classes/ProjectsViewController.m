//
//  ProjectsViewController.m
//  CCPhone
//
//  Created by Alex Hung on 6/21/08.
//  Copyright ThoughtWorks 2008. All rights reserved.
//

#import "ProjectsViewController.h"
#import "CCPhoneAppDelegate.h"
#import "CCProject.h"
#import "ProjectDetailsViewController.h"
#import "OptionsViewController.h"

@implementation ProjectsViewController

@synthesize ccServer;

- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
		self.title = @"Projects";
	}
	
	return self;
}

- (void)viewDidLoad {
	self.view.backgroundColor = [CCPhoneAppDelegate darkGrey];
	self.tableView.separatorColor = [UIColor lightGrayColor];
	
	UIBarButtonItem *optionsButton = [[UIBarButtonItem alloc] initWithTitle:@"Options" style:UIBarButtonItemStylePlain target:self action:@selector(showOptions:)];
	self.navigationItem.leftBarButtonItem = optionsButton;
	[optionsButton release];
	
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(fetchProjects:)];
	self.navigationItem.rightBarButtonItem = refreshButton;
	[refreshButton release];
	
	refreshView = [[RefreshView alloc] initWithFrame:[self.view bounds]];
	[self.view addSubview:refreshView];
	
	statusMessageView = [[StatusMessageView alloc] initWithFrame:[self.view bounds]];
	[self.view addSubview:statusMessageView];
	
	if (ccServer.url) {
		[ccServer loadProjects];
	} else {
		[self showOptions:nil];
	}
}

- (void)fetchProjects:(id)sender {
	statusMessageView.hidden = YES;
	[ccServer fetchProjects:self];
}

- (void)showOptions:(id)sender {
	OptionsViewController *optionsViewController = [[[OptionsViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
	optionsViewController.ccServer = ccServer;
	optionsViewController.refreshDelegate = self;
	
	UINavigationController *optionsNavigationController = [[UINavigationController alloc] initWithRootViewController:optionsViewController];
	[[self navigationController] presentModalViewController:optionsNavigationController animated:YES];
}

- (void)startRefreshing {
	self.navigationItem.rightBarButtonItem.enabled = NO;
	[refreshView startRefreshing];
}

- (void)stopRefreshing {
	[refreshView stopRefreshing];
	self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)showFetchProjectError:(NSString *)message {
	[self stopRefreshing];
	/*
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Refresh Error"
														message:message
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
	[alertView show];
	 */
}

- (void)setAppBadge:(int)failedBuilds {
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:failedBuilds];
}

- (void)refreshView {
	[self stopRefreshing];
	
	if (ccServer.projects.count == 0) {
		statusMessageView.text = @"No projects found.\nPlease check server URL and type.";
		statusMessageView.hidden = NO;
	} else {
		[self.tableView reloadData];		
	}
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellAccessoryDetailDisclosureButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [ccServer.projects count];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = indexPath.row;
	if (row != NSNotFound) {
		ProjectDetailsViewController *projectDetailsController = [[ProjectDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
		projectDetailsController.project = [ccServer.projects objectAtIndex:row];
		
		// Set the stories controller's inspected item to the currently-selected item
		[[self navigationController] pushViewController:projectDetailsController animated:YES];
		[projectDetailsController release];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger rowIndex = [indexPath row];
	
	if (rowIndex == NSNotFound) {
		rowIndex = 0;
	}
	
	return [self getProjectTableViewCell:tableView atRowIndex:rowIndex]; 
}

- (ProjectTableViewCell *)getProjectTableViewCell:(UITableView *)tableView atRowIndex:(NSUInteger)rowIndex {
	NSString *cellIdentifier = @"projectCell";
	
	ProjectTableViewCell *cell = (ProjectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[[ProjectTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
	}
	
	cell.project = [ccServer.projects objectAtIndex:rowIndex];
	
	return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	refreshView.frame = [self.view bounds];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (void)dealloc {
	[refreshView release];
	[statusMessageView release];
	[super dealloc];
}

@end