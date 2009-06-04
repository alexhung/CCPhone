//
//  CCServer.m
//  CCPhone
//
//  Created by Alex Hung on 7/1/08.
//  Copyright 2008 ThoughtWorks. All rights reserved.
//

#import "CCServer.h"


@implementation CCServer

@synthesize url;
@synthesize serverType;
@synthesize numberOfFailedProjects;
@synthesize projects;

static NSArray *filenames = nil; 

+ (void)initialize {
	
    static BOOL initialized = NO;
	
    if (!initialized) {

		NSString *plist = @"('', 'cctray.xml', 'xml', 'XmlStatusReport.aspx' )";
		filenames = [[plist propertyList] copy];

        initialized = YES;
    }
}

- (id)init {
	
	if (self = [super init]) {

		self.serverType = (CCMServerType)[[NSUserDefaults standardUserDefaults] integerForKey:@"serverType"];
		NSString *serverUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"serverUrl"];
		
		if (serverUrl) {
			self.url = [NSURL URLWithString:serverUrl];
		}

		[self loadProjects];
	}

	return self;
}

- (void)initURL {

	CCMServerType ccServerType = self.serverType;
	//NSString *urlString = @"http://ccnetlive.thoughtworks.com/ccnet/";
	NSString *urlString = self.url.absoluteString;
		
	if (!urlString) {
		urlString = @"http://localhost/ccnet";
	}
	
	[self autoDiscoverReportURL:urlString withServerType:ccServerType];
}

- (void)autoDiscoverReportURL:(NSString *)urlString withServerType:(CCMServerType)ccServerType {
	
	urlString = [self removingCruiseControlReportFileName:urlString];
	self.url = [self completeCruiseControlURL:urlString forServerType:ccServerType];
	
	//[[NSUserDefaults standardUserDefaults] setObject:[self.url absoluteString] forKey:@"serverUrl"];
}

- (void)addProject:(CCProject *)newProject {
	
	[projects addObject:newProject];
	
	BOOL reverse = NO;
	[projects sortUsingFunction:projectSorter context:&reverse];
}

NSComparisonResult projectSorter(CCProject *project1, CCProject *project2, void *reverse) {
	
	return [project1.name localizedCaseInsensitiveCompare:project2.name];
}

- (void)removeAllProjects {
	
	[projects removeAllObjects];
}

- (void)loadProjects {
	
	NSMutableArray *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"projects"];
	
	if (data == nil) {
		
		projects = [[NSMutableArray alloc] init];
	}
	else {
		
		NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
		for (NSData *item in data) {
			
			CCProject *project = [NSKeyedUnarchiver unarchiveObjectWithData:item];
			[array addObject:project];
		}
		
		projects = [[NSMutableArray alloc] initWithArray:array];
	}
}

- (void)saveProjects {
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
	for (CCProject *project in projects) {
		
		[array addObject:[NSKeyedArchiver archivedDataWithRootObject:project]];
	}
	
	[[NSUserDefaults standardUserDefaults] setObject:array forKey:@"projects"];
}

- (void)save {
	
	[[NSUserDefaults standardUserDefaults] setInteger:self.serverType forKey:@"serverType"];
	[[NSUserDefaults standardUserDefaults] setObject:[self.url absoluteString] forKey:@"serverUrl"];
	[self saveProjects];
}

- (void)fetchProjects:(UIViewController *)controller {
	
	if (controller) {
		viewController = controller;
	} else {
		
		NSLog(@"controller is nil!");
		return;
	}
	
	if ([viewController respondsToSelector:@selector(startRefreshing)])
		[viewController startRefreshing];
	else {
		
		NSLog(@"%s can’t be placed\n", [NSStringFromClass([viewController class]) UTF8String]);
		return;
	}
	
	@try {
		
		[self initURL];
		
		NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.url
													cachePolicy:NSURLRequestReloadIgnoringCacheData
												timeoutInterval:10];
		
		NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
		if (connection) {
			receivedData = [[NSMutableData data] retain];
		}
	}
	@catch (NSException * e) {
		/*
		if ([viewController respondsToSelector:@selector(showFetchProjectError:)])
			[viewController showFetchProjectError:[e reason]];
		else 
			NSLog(@"%s can’t be placed\n", [NSStringFromClass([viewController class]) UTF8String]);
		 */
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	[connection release];
	[self removeAllProjects];
	numberOfFailedProjects = 0;
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:receivedData];
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
	
	BOOL result = [parser parse];
	
	if (result == NO) {
		
		NSError *error = [parser parserError];
		if (error) {
			
			if ([viewController respondsToSelector:@selector(showFetchProjectError:)])
				[viewController showFetchProjectError:[error localizedDescription]];
			else 
				NSLog(@"%s can’t be placed\n", [NSStringFromClass([viewController class]) UTF8String]);
		}
	}		
	
	[parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"Project"]) {
		
		NSString *name = [attributeDict valueForKey:@"name"];
		NSString *category = [attributeDict valueForKey:@"category"];
		NSString *activity = [attributeDict valueForKey:@"activity"];
		NSString *lastBuildStatus = [attributeDict valueForKey:@"lastBuildStatus"];
		NSString *lastBuildLabel = [attributeDict valueForKey:@"lastBuildLabel"];
		NSString *lastBuildTime = [attributeDict valueForKey:@"lastBuildTime"];
		NSString *nextBuildTime = [attributeDict valueForKey:@"nextBuildTime"];
		NSString *webUrl = [attributeDict valueForKey:@"webUrl"];
		
		CCProject *project = [[CCProject alloc] initWithName:name 
													category:category 
													activity:activity
											 lastBuildStatus:lastBuildStatus
											  lastBuildLabel:lastBuildLabel 
											   lastBuildTime:lastBuildTime
											   nextBuildTime:nextBuildTime 
													  webUrl:webUrl 
												   serverUrl:self.url];
		[self addProject:project];
		
		if ([lastBuildStatus isEqualToString:@"Failure"]) {
			numberOfFailedProjects++;
		}
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	
	[self saveProjects];
	
	if ([viewController respondsToSelector:@selector(refreshView)])
		[viewController refreshView];
	else 
		NSLog(@"%s can’t be placed\n", [NSStringFromClass([viewController class]) UTF8String]);
	
	if ([viewController respondsToSelector:@selector(setAppBadge:)])
		[viewController setAppBadge:self.numberOfFailedProjects];
	else 
		NSLog(@"%s can’t be placed\n", [NSStringFromClass([viewController class]) UTF8String]);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	
	NSLog([error localizedDescription]);
}

+ (CCMServerType)serverTypeFromString:(NSString *)ccServerTypeString {

	if (ccServerTypeString == @"Automatic") {
		return CCMUnknownServer;
	} else if (ccServerTypeString == @"Dashboard") {
		return CCMCruiseControlDashboard;
	} else if (ccServerTypeString == @"Classic") {
		return CCMCruiseControlClassic;
	} else if (ccServerTypeString == @".NET") {
		return CCMCruiseControlDotNetServer;
	} else {
		return CCMUnknownServer;
	}
}

+ (NSString *)serverTypeStringFromType:(CCMServerType)ccServerType {
	
	switch (ccServerType) {
		case CCMUnknownServer:
			return @"Automatic";
			break;
			
		case CCMCruiseControlDashboard:
			return @"Dashboard";
			break;

		case CCMCruiseControlClassic:
			return @"Classic";
			break;

		case CCMCruiseControlDotNetServer:
			return @".NET";
			break;

		default:
			return @"WTF?";
			break;
	}
}

- (NSString *)removingCruiseControlReportFileName:(NSString *)urlString
{
	unsigned index = [filenames indexOfObject:[urlString lastPathComponent]];
	
	if (index == NSNotFound) {
		
		return urlString;
	}

	// can't use deleteLastPathComponent because that normalises the double-slash in http://
	NSMutableString *mutableCopy = [urlString mutableCopy];
	NSRange range = [mutableCopy rangeOfString:[filenames objectAtIndex:index] options:NSBackwardsSearch|NSAnchoredSearch];
	[mutableCopy deleteCharactersInRange:range];
	
	return [NSString stringWithString:mutableCopy];
}

- (NSURL *)urlByAddingSchemeIfNecessary:(NSString *)urlString
{
	if (![urlString hasPrefix:@"http://"] && ![urlString hasPrefix:@"https://"]) {
		
		return [NSURL URLWithString:[@"http://" stringByAppendingString:urlString]];
	}

	return [NSURL URLWithString:urlString];
}

- (NSURL *)completeCruiseControlURL:(NSString *)anUrl forServerType:(CCMServerType)ccServerType withPath:(NSString *)path
{
	NSString *completion = [path stringByAppendingPathComponent:[filenames objectAtIndex:ccServerType]];
	NSString *urlString = anUrl;
	if (![urlString hasSuffix:completion]) {
	
		// can't use appendPathComponent because that normalises the double-slash in http://
		if (![urlString hasSuffix:@"/"]) {
			
			urlString = [urlString stringByAppendingString:@"/"];
		}

		urlString = [urlString stringByAppendingString:completion];
	}

	return [self urlByAddingSchemeIfNecessary:urlString];
}

- (NSURL *)completeCruiseControlURL:(NSString *)anUrl forServerType:(CCMServerType)ccServerType
{
	if (ccServerType == CCMUnknownServer) {
		
		NSEnumerator *urlEnum = [[self completeCruiseControlURLs:anUrl] objectEnumerator];
		NSURL *serverUrl;
		while ((serverUrl = [urlEnum nextObject]) != nil) {
			
			if ([self testConnection:serverUrl]) {
				
				return serverUrl;
			}
		}
		
		return [NSURL URLWithString:anUrl];
	}
	else {
		
		return [self completeCruiseControlURL:anUrl forServerType:serverType withPath:@""];
	}
}

- (BOOL)testConnection:(NSURL *)serverURL
{
	NSURLRequest *request = [NSURLRequest requestWithURL:serverURL
											 cachePolicy:NSURLRequestReloadIgnoringCacheData
										 timeoutInterval:30.0];
	NSHTTPURLResponse *response = nil;
	NSError *error = nil;
	[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

	if (error != nil) {
		
		[NSException raise:@"ConnectionException" format:[error localizedDescription]];
	}
	
	int status = [response statusCode];
	return (status >= 200 && status != 404 && status < 500);
}

- (NSArray *)completeCruiseControlURLs:(NSString *)anUrl
{
	NSMutableSet *urls = [NSMutableSet set];
	[urls addObject:[self completeCruiseControlURL:anUrl forServerType:CCMCruiseControlDashboard]];
	[urls addObject:[self completeCruiseControlURL:anUrl forServerType:CCMCruiseControlDashboard withPath:@"dashboard"]];
	[urls addObject:[self completeCruiseControlURL:anUrl forServerType:CCMCruiseControlClassic]];
	[urls addObject:[self completeCruiseControlURL:anUrl forServerType:CCMCruiseControlDotNetServer]];
	[urls addObject:[self completeCruiseControlURL:anUrl forServerType:CCMCruiseControlDotNetServer withPath:@"ccnet"]];
	return [urls allObjects];
}

- (void)dealloc {
	
	[url release];
	[projects release];
	[receivedData release];
	
	[super dealloc];
}

@end
