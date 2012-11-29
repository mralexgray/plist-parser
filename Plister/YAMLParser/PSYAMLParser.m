//
//  PSYAMLParser.m
//  Plister
//
//  Created by Miles Alden on 11/29/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import "PSYAMLParser.h"

#import "PSArrayAdditions.h"
#import "PSStringContains.h"
#import "PSLogging.h"



@interface PSYAMLParser ()

- (id)checkContainer: (id)containerObject;
- (void)removeTrailingSpaces:(int)d1;
- (void)indentSpaces;
- (void)decrementSpaces;

@end




@implementation PSYAMLParser


// Public
- (id)init {
    
    if ( self = [super init] ) {
        string = @"";
        spaceIndent = 0;
        indentModifier = 3;
        decrementSpaces = 0;
    }
    return self;
}

- (NSString *)parseDictToYAML:(NSDictionary *)dict {
    [self checkContainer:dict];
    return string;
}





// Internal
- (id)checkContainer: (id)containerObject {
    
    // Is it a dictionary or array?
    int y1 = [containerObject respondsToSelector:@selector(allKeys)];
    int y2 = [containerObject respondsToSelector:@selector(arrayByAddingObject:)];
    
    // Add value if not container
    if ( !(y1 || y2) ) {
        string = [string stringByAppendingFormat:@"%@\n", containerObject];
        [self indentSpaces];
    }
    
    // Dictionary object
    if ( y1 ) {
        [self indentSpaces];
        
        //Iterate through all keys
		NSArray *keys = [containerObject allKeys];
		for ( id key in keys ) {
            
            // Pull object from key
            id obj = [containerObject objectForKey:key];
            
            // Is new object a container (dict or array)?
            int a1 = [obj respondsToSelector:@selector(arrayByAddingObject:)];
            int d1 = [obj respondsToSelector:@selector(allKeys)];
            
            // Build opening symbol for type
            // : { <-- opening dictionary brace
            // [   <-- opening array brace
            // :   <-- key : value
            NSString *sym;
            if ( a1 ) { sym = @"[\n"; spaceIndent++; }
            else if ( d1 ) { sym = @": {\n"; spaceIndent++; }
            else { sym = @": "; }
			string = [string stringByAppendingFormat:@"%@ %@", key, sym];
			[self checkContainer:obj];
            if ( d1 ) [self removeTrailingSpaces:d1];
		}
        
	} else if ( y2 ) {
        
		for ( id obj in containerObject ) {
			[self checkContainer:obj];
		}
        [self removeTrailingSpaces:0];
    }
    
    
    
    return nil;
}

- (void)removeTrailingSpaces:(int)d1 {
    // This is extra work..
    // figure out a way around it.
    int num = (int)[string length]-spaceIndent*indentModifier-1;
    decrementSpaces = 1;
    
    NSRange lastChar = NSMakeRange(num, [string length]-num);
    
    NSString *sym;
    if ( d1 ) {
        sym = @" }\n";
    } else {
        sym = @" ]\n";
    }
    string = [string stringByReplacingCharactersInRange:lastChar withString:sym];
    [self indentSpaces];
    
}


- (void)indentSpaces {
    if ( decrementSpaces ) { [self decrementSpaces]; }
    for ( int i = 0; i < spaceIndent*indentModifier; i++ ) {
        string = [string stringByAppendingFormat:@" "];
    }
    [string getCString:chars maxLength:300 encoding:1];
}

- (void)decrementSpaces {
    
    if ( spaceIndent > -1 ) spaceIndent--;
    decrementSpaces = 0;
}

@end
