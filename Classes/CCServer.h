//
//  CCServer.h
//  CCPhone
//
//  Created by Alex Hung on 7/1/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCProject.h"

@interface CCServer : NSObject {
	NSURL *url;
	int serverType;
	NSMutableArray *projects;
	NSMutableData *receivedData;
	int numberOfFailedProjects;
	
	UIViewController *viewController;
}

typedef enum {
	CCMUnknownServer = 0,
	CCMCruiseControlDashboard = 1,
	CCMCruiseControlClassic = 2,
 	CCMCruiseControlDotNetServer = 3   // CC.rb uses the same URL
} CCMServerType;

NSComparisonResult projectSorter(CCProject *project1, CCProject *project2, void *reverse);

- (void)addProject:(CCProject *)newProject;
- (void)removeAllProjects;
- (void)loadProjects;
- (void)saveProjects;
- (void)save;
- (void)fetchProjects:(UIViewController *)controller;

+ (CCMServerType)serverTypeFromString:(NSString *)ccServerTypeString;
+ (NSString *)serverTypeStringFromType:(CCMServerType)ccServerType;

- (void)initURL;
- (void)autoDiscoverReportURL:(NSString *)urlString withServerType:(CCMServerType)serverType;
- (NSString *)removingCruiseControlReportFileName:(NSString *)urlString;
- (NSURL *)completeCruiseControlURL:(NSString *)anUrl forServerType:(CCMServerType)serverType;
- (NSArray *)completeCruiseControlURLs:(NSString *)anUrl;
- (BOOL)testConnection:(NSURL *)serverURL;

@property (nonatomic, retain) NSURL *url;
@property (nonatomic) int serverType;
@property (nonatomic) int numberOfFailedProjects;
@property (nonatomic, retain) NSArray *projects;

@end
