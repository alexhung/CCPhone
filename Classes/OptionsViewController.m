//
//  OptionsViewController.m
//  CCPhone
//
//  Created by Alex Hung on 12/6/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import "OptionsViewController.h"
#import "OptionsServerUrlTableViewCell.h"
#import "OptionsServerTypeViewController.h"
#import "OptionsServerTypeTableViewCell.h"

@implementation OptionsViewController

@synthesize ccServer;
@synthesize refreshDelegate;

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
		
		self.navigationController.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Options";
	
	self.view.backgroundColor = [CCPhoneAppDelegate darkGrey];
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	self.tableView.separatorColor = [UIColor lightGrayColor];
	self.tableView.sectionHeaderHeight = SETTING_HEADER_HEIGHT;
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissView:)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
}

- (void)dismissView:(id)sender {
	
	[[self navigationController] dismissModalViewControllerAnimated:YES];
	[refreshDelegate performSelector:@selector(fetchProjects:)];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 6, SETTING_HEADER_ROW_WIDTH, SETTING_HEADER_HEIGHT)];
	headerView.backgroundColor = [UIColor clearColor];
	
	UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 6, SETTING_HEADER_ROW_WIDTH, SETTING_HEADER_HEIGHT)];
	headerLabel.font = [UIFont boldSystemFontOfSize:SETTING_HEADER_FONT_SIZE];
	headerLabel.text = @"Server";
	headerLabel.textColor = [UIColor lightGrayColor];
	headerLabel.backgroundColor = [UIColor clearColor];
	
	[headerView addSubview:headerLabel];
	return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSUInteger rowIndex = [indexPath row];
	
	if (rowIndex == NSNotFound) {
		rowIndex = 0;
	}
	
	NSString *cellIdentifier = @"OptionsCell";
    
	switch (rowIndex) {
			
		case 0:
		{			
			OptionsServerUrlTableViewCell *cell = (OptionsServerUrlTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
			if (cell == nil) {

				cell = [[[OptionsServerUrlTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
			}
			cell.title = @"URL";
			cell.ccServer = ccServer;			
			return cell;
		}
			
		case 1:
		{
			OptionsServerTypeTableViewCell *cell = (OptionsServerTypeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
			if (cell == nil) {
				
				cell = [[[OptionsServerTypeTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
			}
			cell.title = @"Type";
			cell.content = [CCServer serverTypeStringFromType:ccServer.serverType];			
			return cell;
		}			
		default:
			return nil;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([indexPath row] == 1) {
		
		OptionsServerTypeViewController *serverTypeViewController = [[OptionsServerTypeViewController alloc] initWithStyle:UITableViewStyleGrouped];
		serverTypeViewController.ccServer = self.ccServer;
		[self.navigationController pushViewController:serverTypeViewController animated:YES];
		[serverTypeViewController release];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	[self.tableView reloadData];
}

- (void)dealloc {
	
	[ccServer release];
	[refreshDelegate release];
    [super dealloc];
}


@end

