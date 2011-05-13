//
//  DCTUIKitAppDelegate.m
//  DCTUIKit
//
//  Created by Daniel Tull on 9.10.2010.
//  Copyright (c) 2010 Daniel Tull. All rights reserved.
//

#import "DCTUIKitAppDelegate.h"
#import "TestViewController.h"
#import "DCTUITabBar.h"

#import "UIColor+DCTHex.h"
#import "UIColor+DCTComponents.h"
#import "TestTableViewController.h"
#import "TestDCTViewController.h"

@implementation DCTUIKitAppDelegate


@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	/*
	UIColor *c1 = [UIColor dct_colorWithHexValue:0xFFFFFF];
	NSLog(@"c1 r:%f g:%f b:%f a:%f", c1.dct_red, c1.dct_green, c1.dct_blue, c1.dct_alpha);
	
	UIColor *c2 = [UIColor dct_colorWithHexString:@"FFFFFF"];
	NSLog(@"c2 r:%f g:%f b:%f a:%f", c2.dct_red, c2.dct_green, c2.dct_blue, c2.dct_alpha);
	
	UIColor *c3 = [UIColor dct_colorWithHexString:@"121212"];
	NSLog(@"c3 r:%f g:%f b:%f a:%f", c3.dct_red, c3.dct_green, c3.dct_blue, c3.dct_alpha);
	
	UIColor *c4 = [UIColor dct_colorWithHexValue:0x091020];
	NSLog(@"c4 r:%f g:%f b:%f a:%f", c4.dct_red, c4.dct_green, c4.dct_blue, c4.dct_alpha);
	*/
	
	TestDCTViewController *vc1 = [[TestDCTViewController alloc] init];
	vc1.title = @"One";
	
	TestTableViewController *vc2 = [[TestTableViewController alloc] init];
	vc2.title = @"Two";
	
	TestViewController *vc3 = [[TestViewController alloc] init];
	vc3.title = @"Three";
	
	
	
	tabs = [[DCTTabBarController alloc] initWithViewControllers:[NSArray arrayWithObjects:vc1, vc2, vc3, nil]];
	
	//DCTUITabBar *tabBar = [[DCTUITabBar alloc] init];
	//tabs.tabBar = tabBar;
	//[tabBar release];
	
	[vc1 release];
	[vc2 release];
	
	[window addSubview:tabs.view];
	
	// Override point for customization after application launch.
	[window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {

	// Saves changes in the application's managed object context before the application terminates.
	NSError *error = nil;
	if (managedObjectContext) {
	    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
	        /*
	         Replace this implementation with code to handle the error appropriately.
	         
	         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
	         */
	        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	        abort();
	    } 
	}
}

- (void)dealloc {

	[window release];
	[managedObjectContext release];
	[managedObjectModel release];
	[persistentStoreCoordinator release];
    [super dealloc];
}

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator) {
        return persistentStoreCoordinator;
    }
    
    NSURL *storeUrl = [NSURL fileURLWithPath:[[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"DCTUIKit.sqlite"]];
    
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible
         * The schema for the persistent store is incompatible with current managed object model
         Check the error message to determine what the actual problem was.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator;
}

#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
