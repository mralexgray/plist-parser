//
//  PLAppDelegate.h
//  Plister
//
//  Created by Miles Alden on 11/16/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PLAppDelegate : NSObject <NSApplicationDelegate>

@property (strong) NSString *str, *elementName;
@property (strong) NSMutableString *strEdits, *output;
@property (assign) IBOutlet NSWindow *window;
@property int numIndents;
@end
