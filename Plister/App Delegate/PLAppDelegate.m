//
//  PLAppDelegate.m
//  Plister
//
//  Created by Miles Alden on 11/16/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import "PLAppDelegate.h"
#import "PSParseManager.h"
#define COLOR ORANGE

@implementation PLAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{    
    // Insert code here to initialize your application
//    self.logColor = ORANGE;
    
    PSParseManager *parseManager = [[PSParseManager alloc] init];
    [parseManager beginParseIterations];

}



@end
