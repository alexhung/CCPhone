//
//  OptionsServerTypeViewController.m
//  CCPhone
//
//  Created by Alex Hung on 12/7/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import "OptionsServerTypeViewController.h"
#import "CCPhoneAppDelegate.h"

@implementation OptionsServerTypeViewController

@synthesize ccServer;


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Server Type";
	
	self.view.backgroundColor = [CCPhoneAppDelegate darkGrey];
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	self.tableView.separatorColor = [UIColor lightGrayColor];
	self.tableView.sectionHeaderHeight = SETTING_HEADER_HEIGHT;
}


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
	headerLabel.text = @"Type";
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
    return 4;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSUInteger rowIndex = [indexPath row];
	NSString *cellIdentifier = @"ServerTypeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
    }
    
    switch (rowIndex) {
		case 0:
			cell.accessoryType = ccServer.serverType == CCMUnknownServer ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
			cell.text = [CCServer serverTypeStringFromType:CCMUnknownServer];
			break;

		case 1:
			cell.accessoryType = ccServer.serverType == CCMCruiseControlDashboard ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
			cell.text = [CCServer serverTypeStringFromType:CCMCruiseControlDashboard];
			break;
			
		case 2:
			cell.accessoryType = ccServer.serverType == CCMCruiseControlClassic ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
			cell.text = [CCServer serverTypeStringFromType:CCMCruiseControlClassic];
			break;
			
		case 3:
			cell.accessoryType = ccServer.serverType == CCMCruiseControlDotNetServer ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
			cell.text = [CCServer serverTypeStringFromType:CCMCruiseControlDotNetServer];
			break;
			
		default:
			break;
	}

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	
    NSInteger serverTypeIndex = (int)ccServer.serverType;
    if (serverTypeIndex == indexPath.row) {
        return;
    }
	
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:serverTypeIndex inSection:0];
	
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
		
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        ccServer.serverType = indexPath.row;
		[ccServer save];
    }
	
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
		
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }	
}


- (void)dealloc {
	[ccServer release];
    [super dealloc];
}


@end

