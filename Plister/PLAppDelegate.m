//
//  PLAppDelegate.m
//  Plister
//
//  Created by Miles Alden on 11/16/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import "PLAppDelegate.h"
#import "AbsTimer.h"
#import "PSStringContains.h"
#import "NSObject+ClassName.h"

#define PLIST_TEST_PATH @"/Users/MilesAlden/Documents//Local/cg_adminOnly.plist"


@interface NSObject (MyCatergory)

- (int)isContainerClass;
- (int)isArray;
- (int)isDictionary;

@end

@implementation NSObject (MyCatergory)

- (int)isContainerClass {
    
    if ( [self isKindOfClass:NSClassFromString(@"NSDictionary")] ||
        [self isKindOfClass:NSClassFromString(@"NSArray")]) {
        return 1;
    }
    
    return 0;
}

- (int)isDictionary {
    if ( [self isKindOfClass:NSClassFromString(@"NSDictionary")]) {
        return 1;
    }    
    return 0;
}

- (int)isArray {
    if ( [self isKindOfClass:NSClassFromString(@"NSArray")]) {
        return 1;
    }
    return 0;
}



@end


@implementation PLAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    AbsTimer *timer = [[AbsTimer alloc] init];
    
    NSArray *functions = @[@"parserBetter"];
    
    for ( NSString *item in functions ) {
        NSLog(@"Running function: %@", item);
        [timer startTimer];
        [self performSelector:NSSelectorFromString(item)];
    }
    
    [timer stopTimer];
    NSLog(@"Action completed in %0.5f seconds", [timer timeElapsedInSeconds]);
}


- (void)parserBetter {
    
//    self.str = @"<array><dict><dict><this></this><something></something></dict><key>A</key><string>AA</string></dict></array>";
    NSError *err;
    self.str = [NSString stringWithContentsOfFile:PLIST_TEST_PATH encoding:NSUTF8StringEncoding error:&err];
    self.str = 
    self.strEdits = [NSMutableString stringWithString:self.str];
    self.output = [NSMutableString stringWithFormat:@"\n"];
    self.elementName = @"";
    
    [self addNewlinesAt:@"<[^>]+>"];//@"<dict>|<array>|</dict>|</array>"];
    
    NSLog(@"\n%@", self.strEdits);
    
}

- (void)addNewlinesAt: (NSString *)location {
 
    self.numIndents = 0;
    NSMutableArray *elements = [NSMutableArray array];
    
    NSError *err;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:location
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&err];
    NSArray *matches = [regex matchesInString:self.str
                                      options:0
                                        range:NSMakeRange(0, self.str.length)];
    
    int i = 0;
    for ( NSTextCheckingResult *match in matches ) {
        
        // Ends of tags
        self.elementName = [self.str substringWithRange:[match range]];
        [elements addObject:self.elementName];
        
        /*
        [self.strEdits insertString:@"\n" atIndex:[match range].location+i+[match range].length];
        i++;
        
        // Indent
        if ( [self.elementName containsString:@"<array>"] || [self.elementName containsString:@"<dict>"] ) {
            self.numIndents++;
            for ( int m = 0; m < self.numIndents; m++ ) {
                [self.strEdits insertString:@"\t" atIndex:[match range].location+i+[match range].length];
                i++;
            }
        }
        
        // Beginnings of tags
        if ( [self.elementName containsString:@"</array>"] || [self.elementName containsString:@"</dict>"] ) {
            [self.strEdits insertString:@"\n" atIndex:[match range].location+i-1];
            i++;
        }
         */
        
    }
    
    int count = 0;
    for ( NSString *elm in elements ) {
        
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

        }
        count++;
    }

    NSLog(@"output: \n%@\n", self.output);

    
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
        
    
    NSLog(@"\n%@", output);
    
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
