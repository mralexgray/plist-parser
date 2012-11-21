//
//  PSParseManager.m
//  Plister
//
//  Created by Miles Alden on 11/17/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import "PSParseManager.h"

#import "PSTimer.h"
#import "PSStringContains.h"
#import "NSObject+ClassName.h"
#import "PSArrayAdditions.h"

#define PLIST_TEST_PATH @"/Users/MilesAlden/Documents/Ensighten/Local/cg_adminOnly.plist"
#define COLOR BURGUNDY

@implementation PSParseManager

- (id)init {
    
    if ( self = [super init] ) {
        // Initial stuff
//        self.logColor = BURGUNDY;
        self.parseObject = [[PSParseObject alloc] init];

    }
    
    return self;
}

- (void)beginParseIterations {
    
    // timer for the hell of it
    PSTimer *timer = [[PSTimer alloc] init];
    
    
    NSArray *functions = @[@"parseBetter"];
    
    @try {
        for ( NSString *item in functions ) {
            Log(@"Running function: %@", item);
            [timer startTimer];
            [self performSelector:NSSelectorFromString(item)];
        }
    }
    @catch (NSException *e) {
        LogError(@"%@", e);
    }
    
    [timer stopTimer];
    Log(@"Action completed in %0.5f seconds", [timer timeElapsedInSeconds]);
}




- (void)parseBetter {
    
    //    self.parseObject.str = @"<array><dict><dict><this></this><something></something></dict><key>A</key><string>AA</string></dict></array>";
    NSError *err;
    self.parseObject.str = [NSString stringWithContentsOfFile:PLIST_TEST_PATH encoding:NSUTF8StringEncoding error:&err];
    if ( nil == self.parseObject.str ) {
        Log(@"String to parse is nil.");
        return;
    }
    
    self.strEdits = [NSMutableString stringWithString:self.parseObject.str];
    self.output = [NSMutableString stringWithFormat:@"\n"];
    self.elementName = @"";
    self.elements = [NSMutableArray array];
    
    [self addNewlinesAt:@"<[^>]+>"];//@"<dict>|<array>|</dict>|</array>"];
    
    Log(@"output: \n%@\n", self.output);
}

- (NSString *)getValueWithTweenRange:(NSRange)start end:(NSRange)end {
    
    if ( nil == self.parseObject.str || end.location > self.parseObject.str.length || end.location+end.length > self.parseObject.str.length) {
        Log(@"End range beyond string length.");
        return nil;
    }
    
    Log(@"Building range");
    NSRange newRange = [self getTweenRange:start end:end];
    return [self.parseObject.str substringWithRange:newRange];
}

- (NSRange)getTweenRange:(NSRange)start end:(NSRange)end {
    
    unsigned long locationDiff = start.location+start.length;
    unsigned long lengthDiff = end.location;
    return NSMakeRange(locationDiff, lengthDiff);
    
}

- (void)addNewlinesAt: (NSString *)location {
    
    self.numIndents = 0;
    
    NSError *err;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:location
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&err];
    self.matches = [regex matchesInString:self.parseObject.str
                                  options:0
                                    range:NSMakeRange(0, self.parseObject.str.length)];
    
    for ( NSTextCheckingResult *match in self.matches ) {
        // Ends of tags
        self.elementName = [self.parseObject.str substringWithRange:[match range]];
        [self.elements addObject:self.elementName];
    }
    
    [self indentContainerKeys];
    
}


- (void)indentContainerKeys {
    
    
    int count = 0;
    
    for ( NSString *elm in self.elements ) {
        
        NSString *editedString = @"";
        
        // Root appends no tabs
        if ( count == 0 ) {
            editedString = [elm stringByAppendingString:@"\n"];
            [self.output appendString: editedString];
            self.numIndents++;
        }
        
        // Append tabs first, then newline
        else if ( [elm containsString:@"<array"] || [elm containsString:@"<dict"] ) {
            for ( int i = 0; i < self.numIndents; i++ ) {
                editedString = [editedString stringByAppendingString:@"\t"];
            }
            editedString = [editedString stringByAppendingString:elm];
            editedString = [editedString stringByAppendingString:@"\n"];
            [self.output appendString: editedString];
            self.numIndents++;
            
            
            // Unwind tabs and add newlines
        } else if ( [elm containsString:@"</dict"] || [elm containsString:@"</array"]) {
            self.numIndents--;
            for ( int i = 0; i < self.numIndents; i++ ) {
                editedString = [editedString stringByAppendingString:@"\t"];
            }
            editedString = [editedString stringByAppendingString:elm];
            editedString = [editedString stringByAppendingString:@"\n"];
            [self.output appendString: editedString];
            
            
            // Append newline to tag ends
        } else if ( [elm containsString:@"</"] ) {
            editedString = [elm stringByAppendingString:@"\n"];
            [self.output appendString: editedString];
            
            
            // Add the rest
        } else {
            for ( int i = 0; i < self.numIndents; i++ ) {
                editedString = [editedString stringByAppendingString:@"\t"];
            }
            [self.output appendString: [editedString stringByAppendingString:elm]];
            
            // Add value
            NSRange endRange;
            if ( ![self.matches isIndexValid:count+1] ) {
                endRange = NSMakeRange(0,0);
            } else {
                endRange = [[self.matches objectAtIndex:count+1] range];
            }
            [self.output appendString:[self getValueWithTweenRange:
                                       [[self.matches objectAtIndex:count] range]
                                                               end:endRange]];
        }
        
        count++;
    }
    
}

- (void)parseTreeAsText {
    
    //    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:PLIST_TEST_PATH];
    
    
    // XML Plist Parsing
    int currentIndent = 0;
    // Scan line 1
    
    NSString *str = @"<dict><key>A<key/><string>AA<string/><dict/>";
    NSMutableString *output = [NSMutableString string];
    NSString *elementName = @"";
    int keyStartIndex = 0;
    int keyEndIndex = 0;
    
    int valueStartIndex = 0;
    int valueEndIndex = 0;
    // (NSString *)findKey()
    
    unsigned long len = str.length;
    int ind = 0;
    for (int i = ind; i < len; i++) {
        
        const char *currentChar = [[str substringWithRange:NSMakeRange(i,1)] cStringUsingEncoding:NSASCIIStringEncoding];
        
        // Search for < character
        if ( strcmp(currentChar, "<") == 0 ) {
            // Found start
            // Mark key beginning
            keyStartIndex = i;
        } else if ( strcmp(currentChar, ">") == 0 ) {
            // Pull characters until > character
            keyEndIndex = i;
            
            elementName = [str substringWithRange:NSMakeRange(keyStartIndex, abs(keyStartIndex-keyEndIndex-1) )];
            [output appendString:elementName];
            
            
            // Get actual value
            valueStartIndex = i;
            for ( int o = i; o < len; o++ ){
                const char *curValChar = [[str substringWithRange:NSMakeRange(o,1)] cStringUsingEncoding:NSASCIIStringEncoding];
                if ( strcmp(currentChar, "<") == 0 ) {
                    valueEndIndex = o;
                    break;
                }
                //                    output
                
            }
            
            [output appendString:@"\n"];
            
            if ( [elementName containsString:@"dict"] || [elementName containsString:@"array"] ) {
                currentIndent++;
            }
            // Add tabs
            for ( int m = 0; m < currentIndent; m++) {
                [output appendString:@"\t"];
            }
            
            // Mark where we left off
            ind = i;
        }
    }
    
    
    Log(@"\n%@", output);
    
    // If Dictionary or Array
    // currentIndent+=indent;
    // Count children
    
}

- (int)buildTableViewsForDictionary: (NSDictionary *)dic {
    
    int success = 0;
    
    
    
    return success;
    
}

- (void)extractDictsAndArrays: (NSDictionary *)dic {
    
    // Arrg...I want to do this as
    // a block...this is being cumbersome.
    //    int (^isContainerClass)(id);
    //    isContainerClass = ^(id anItem) {
    //
    //        if ( [anItem isKindOfClass:NSClassFromString(@"NSDictionary")] ||
    //            [anItem isKindOfClass:NSClassFromString(@"NSArray")]) {
    //            return 1;
    //        }
    //
    //        return 0;
    //
    //    };
    
    // Containers
    NSMutableArray *dictionaries = [NSMutableArray array];
    NSMutableArray *arrays = [NSMutableArray array];
    
    
    for ( id item in dic ) {
        
        if ( [item isDictionary] ) {
            [dictionaries addObject:item];
        } else if ( [item isArray] ) {
            [arrays addObject:item];
        }
        
    }
}



@end
