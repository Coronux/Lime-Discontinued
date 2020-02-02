//
//  main.m
//  Lime
//
//  Created by PixelOmer on 2.02.2020.
//  Copyright © 2020 Citrusware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMAppDelegate.h"
#import "LMDatabase.h"
#import "LMRepository.h"

int main(int argc, char * argv[]) {
	NSString * appDelegateClassName;
	@autoreleasepool {
	    // Setup code that might create autoreleased objects goes here.
		[LMDatabase sharedInstance]; // Initialize shared instance
	    appDelegateClassName = NSStringFromClass([LMAppDelegate class]);
	}
	return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
