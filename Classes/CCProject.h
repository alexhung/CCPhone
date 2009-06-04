//
//  CCProject.h
//  CCPhone
//
//  Created by Alex Hung on 6/21/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 <CruiseControl>
	<Projects>
		<Project name="ecto 3" category="" activity="Sleeping" status="Running" lastBuildStatus="Success" lastBuildLabel="1" lastBuildTime="2008-06-21T18:03:47.6370096-04:00" nextBuildTime="9999-12-31T23:59:59.9999999-05:00" webUrl="http://VMWAREXP/ccnet" buildStage="" />
	</Projects>
	<Queues>
		<Queue name="ecto 3" />
	</Queues>
 </CruiseControl>
 */

@interface CCProject : NSObject <NSCoding> {
	NSString *name;
	NSString *category;
	NSString *activity;
	NSString *lastBuildStatus;
	NSString *lastBuildLabel;
	NSDate *lastBuildTime;
	NSDate *nextBuildTime;
	NSString *webUrl;
	NSURL *serverUrl;
}

+ (NSString *)convertDateToString:(NSDate *)date;

- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;

- (NSString *)getServerAlias;

- (NSDate *)convertStringToDate:(NSString *)dateString;
- (id)initWithName:(NSString *)name category:(NSString *)category activity:(NSString *)newActivity
			lastBuildStatus:(NSString *)lastBuildStatus lastBuildLabel:(NSString *)lastBuildLabel
	 lastBuildTime:(NSString *)lastBuildTime nextBuildTime:(NSString *)nextBuildTime webUrl:(NSString *)webUrl
		serverUrl:(NSURL *)serverUrl;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *activity;
@property (nonatomic, retain) NSString *lastBuildStatus;
@property (nonatomic, retain) NSString *lastBuildLabel;
@property (nonatomic, retain) NSDate *lastBuildTime;
@property (nonatomic, retain) NSDate *nextBuildTime;
@property (nonatomic, retain) NSString *webUrl;
@property (nonatomic, retain) NSURL *serverUrl;

@end
