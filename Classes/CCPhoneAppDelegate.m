#import "CCPhoneAppDelegate.h"
#import "ProjectsViewController.h"

@implementation CCPhoneAppDelegate

@synthesize window;
@synthesize navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	ProjectsViewController *rootViewController = [[ProjectsViewController alloc] initWithStyle:UITableViewStylePlain];
	ccServer = [[CCServer alloc] init];
	rootViewController.ccServer = ccServer;
	
	navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
	navigationController.navigationBar.tintColor = [UIColor blackColor];
	[rootViewController release];
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[ccServer save];
}

- (void)dealloc {
	[ccServer release];
	
	[navigationController release];
	[window release];
	[super dealloc];
}

+ (UIColor*)darkGrey {
	return [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0];
}

+ (UIColor*)lightGrey {
	return [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.0];
}

@end
