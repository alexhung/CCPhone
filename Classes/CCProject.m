//
//  CCProject.m
//  CCPhone
//
//  Created by Alex Hung on 6/21/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import "CCProject.h"


@implementation CCProject

@synthesize name;
@synthesize category;
@synthesize activity;
@synthesize lastBuildStatus;
@synthesize lastBuildLabel;
@synthesize lastBuildTime;
@synthesize nextBuildTime;
@synthesize webUrl;
@synthesize serverUrl;

// lastBuildTime="2008-06-21T18:03:47.6370096-04:00" - CC.NET
// lastBuildTime="2008-12-05T15:30:48" - Cruise
static NSString *XML_DATE_FORMAT = @"yyyy-MM-dd'T'HH:mm:ss";
static NSDateFormatter *dateFormatter;

+ (void)initialize {
	static BOOL initialized = NO;
	if (!initialized) {
		[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:XML_DATE_FORMAT];
		initialized = YES;
	}
}

-(id)initWithName:(NSString *)newName category:(NSString *)newCategory activity:(NSString *)newActivity
		   lastBuildStatus:(NSString *)newLastBuildStatus lastBuildLabel:(NSString *)newLastBuildLabel
	lastBuildTime:(NSString *)newLastBuildTime nextBuildTime:(NSString *)newNextBuildTime
		   webUrl:(NSString *)newWebUrl serverUrl:(NSURL *)newServerUrl {
	
	self.name = newName;
	self.category = newCategory;
	self.activity = newActivity;
	self.lastBuildStatus = newLastBuildStatus;
	self.lastBuildLabel = newLastBuildLabel;
	
	self.lastBuildTime = [self convertStringToDate:[newLastBuildTime substringToIndex:19]];
	
	if (newNextBuildTime) {
		self.nextBuildTime = [self convertStringToDate:[newNextBuildTime substringToIndex:19]];
	}

	self.webUrl = newWebUrl;
	self.serverUrl = newServerUrl;
	
	return self;
}

- (NSDate *)convertStringToDate:(NSString *)dateString {
	return [dateFormatter dateFromString:dateString];
}

+ (NSString *)convertDateToString:(NSDate *)date {
	NSDateFormatter *displayFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[displayFormatter setLocale:[NSLocale currentLocale]];
	[displayFormatter setTimeZone:[NSTimeZone systemTimeZone]];
	[displayFormatter setDateStyle:NSDateFormatterShortStyle];
	[displayFormatter setTimeStyle:NSDateFormatterShortStyle];
	return [displayFormatter stringFromDate:date];
}

- (NSString *)getServerAlias {
	NSString *serverAlias = [NSString string];
	
	NSArray *splitPaths = [webUrl componentsSeparatedByString:@"/"];
	for (int index = 0; index < splitPaths.count; index++) {
		NSString *path = [splitPaths objectAtIndex:index];
		if ([path isEqualToString:@"server"] && (index + 1) < splitPaths.count) {
			serverAlias = [splitPaths objectAtIndex:(index + 1)];
		}
	}
	
	return serverAlias;
}

- (id)initWithCoder:(NSCoder *)coder {
	self.name = [coder decodeObjectForKey:@"name"];
	self.category = [coder decodeObjectForKey:@"category"];
	self.activity = [coder decodeObjectForKey:@"activity"];
	self.lastBuildStatus = [coder decodeObjectForKey:@"lastBuildStatus"];
	self.lastBuildLabel = [coder decodeObjectForKey:@"lastBuildLabel"];
	self.lastBuildTime = [coder decodeObjectForKey:@"lastBuildTime"];
	self.nextBuildTime = [coder decodeObjectForKey:@"nextBuildTime"];
	self.webUrl = [coder decodeObjectForKey:@"webUrl"];
	self.serverUrl = [coder decodeObjectForKey:@"serverUrl"];
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:name forKey:@"name"];
	[coder encodeObject:category forKey:@"category"];
	[coder encodeObject:activity forKey:@"activity"];
	[coder encodeObject:lastBuildStatus forKey:@"lastBuildStatus"];
	[coder encodeObject:lastBuildLabel forKey:@"lastBuildLabel"];
	[coder encodeObject:lastBuildTime forKey:@"lastBuildTime"];
	[coder encodeObject:nextBuildTime forKey:@"nextBuildTime"];
	[coder encodeObject:webUrl forKey:@"webUrl"];
	[coder encodeObject:serverUrl forKey:@"serverUrl"];
}

@end
