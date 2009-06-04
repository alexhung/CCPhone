//
//  CCPhoneAppDelegate.h
//  CCPhone
//
//  Created by Alex Hung on 6/21/08.
//  Copyright ThoughtWorks 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCServer.h"

#define SETTING_HEADER_FONT_SIZE 16.0
#define SETTING_HEADER_HEIGHT 36.0
#define SETTING_HEADER_ROW_WIDTH 308.0

@interface CCPhoneAppDelegate : NSObject <UIApplicationDelegate> {
	
	CCServer *ccServer;
	
	IBOutlet UIWindow *window;
	IBOutlet UINavigationController *navigationController;
}

+ (UIColor*)darkGrey;
+ (UIColor*)lightGrey;

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@end

