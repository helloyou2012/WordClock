//
//  AppDelegate.m
//  WordClock
//
//  Created by ZhenzhenXu on 12/25/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataEnvir.h"
#import "Word.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
    // Override point for customization after application launch.
    //Set db file name and model file name.
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"word_clock.sqlite"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]) {
        NSURL *sqliteURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"word_clock" ofType:@"sqlite"]];
        
        NSError* err = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtURL:sqliteURL toURL:storeURL error:&err]) {
            NSLog(@"Oops, could copy preloaded data");
        }
    }
    
    [CoreDataEnvir registDefaultDataFileName:@"word_clock.sqlite"];
    [CoreDataEnvir registDefaultModelFileName:@"word_clock"];
    
    NSArray *words =[Word items];
    NSLog(@"Rows:%lu",(unsigned long)words.count);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	[[CoreDataEnvir mainInstance] saveDataBase];
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
