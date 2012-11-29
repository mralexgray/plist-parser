//
//  NSDictionary+SettingsDictionaries.m
//  
//
//  Created by Miles Alden on 8/7/12.
//
//

#import "PSDictionaryAdditions.h"
#import "PSArrayAdditions.h"
#import "PSStringContains.h"
#import "PSLogging.h"


#define COLOR CANTALOUPE

static NSString *string = @"";
static int spaceIndent = 0;
static int indentModifier = 3;

@implementation NSDictionary (SettingsDictionaries)

- (BOOL)containsKey: (NSString *)key {
    
    // Could also do this:
    // return (nil != [self objectForKey:key]);
    
    BOOL retVal = 0;
    NSArray *allKeys = [self allKeys];
    retVal = [allKeys containsObject:key];
    return retVal;
    
}


static char chars[300];
static int decrementSpaces = 0;

+ (id)checkContainer: (id)containerObject {
		
    int y1 = [containerObject respondsToSelector:@selector(allKeys)];
    int y2 = [containerObject respondsToSelector:@selector(arrayByAddingObject:)];
    
    if ( !(y1 || y2) ) {
         string = [string stringByAppendingFormat:@"%@\n", containerObject];
        [NSDictionary indentSpaces];
    }

    if ( y1 ) {
        [NSDictionary indentSpaces];
		NSArray *keys = [containerObject allKeys];
		for ( id key in keys ) {
            id obj = [containerObject objectForKey:key];
            int a1 = [obj respondsToSelector:@selector(arrayByAddingObject:)];
            int d1 = [obj respondsToSelector:@selector(allKeys)];
            NSString *sym;
            if ( a1 ) { sym = @"[\n"; spaceIndent++; }
            else if ( d1 ) { sym = @":\n"; spaceIndent++; }
            else { sym = @": "; }
			string = [string stringByAppendingFormat:@"%@ %@", key, sym];
			[NSDictionary checkContainer:obj];
		}
		
	} else if ( y2 ) {
//        [NSDictionary indentSpaces];
		for ( id obj in containerObject ) {
			[NSDictionary checkContainer:obj];
		}
        NSRange lastChar = NSMakeRange([string length]-spaceIndent*indentModifier-1, 1);
        string = [string stringByReplacingCharactersInRange:lastChar withString:@" ]\n"];
        decrementSpaces = 1;
    }
    

    
    return nil;
}


+ (void)indentSpaces {
    if ( decrementSpaces ) { [NSDictionary decrementSpaces]; }
    for ( int i = 0; i < spaceIndent*indentModifier; i++ ) {
        string = [string stringByAppendingFormat:@" "];
    }
    [string getCString:chars maxLength:300 encoding:1];
}

+ (void)decrementSpaces {
    for ( int i = 0; i < indentModifier; i++ ) {
        spaceIndent--;
    }
}



- (NSString *)YAMLstring {
    
    
    
    
    
//    NSMutableString *string = [NSMutableString stringWithString:@"\n"];
    
    
    

        [NSDictionary checkContainer:self];
        printf("\r%s", [string cStringUsingEncoding:1]);

//        string = [self traverseTree:string key:key obj: self];
    
    /*
        if ( [self hasChildren:key] ) {
            [string appendFormat:@"%@\n", key];
            spaceCount++;
            
            if ( [[self objectForKey:key] respondsToSelector:@selector(allKeys)] ) {
                
                for ( id key2 in [[self objectForKey:key] allKeys] ) {
                    [string appendFormat:@"%@ : %@\n", key2, [self objectForKey:key]];
                }
            }
            
        
        } else {
            for ( int i = 0; i < spaceCount; i++) {
                [string appendString:@" "];
            }
            [string appendFormat:@"%@\n", key];
            
        }
    }
    */
    return string;
    
}

- (NSString *)traverseTree:(NSString *)string key:(NSString *)key obj:(id)obj {
    
    printf("\r%s", [string cStringUsingEncoding:NSASCIIStringEncoding]);
    
    // Do I have keys?
    // Check first key
    // Is it a dictionary?
    //    *YES*
    //    Does it have keys?
    //    Check first key
    //    Is it a dictionary?
    //    *NO*
    //    Is it an array?
    //    *YES*
    //        Does it have objects?
    //        Check first object
    //        Is it a dictionary?
    //        Is it an array?
    //        *NO*
    //        Add stringified object
    //    Add key name or class name to string
    //    Check next key
    //    Is it a dictionary or array?
    //    *NO*
    //    Add key name to string
    //    Any more keys?
    //    *NO*
    // Check next key
    
    
    
    
    if ( [obj respondsToSelector:@selector(allKeys)] ) {
        for ( id key2 in [[obj objectForKey:key] allKeys] ) {
            string = [string stringByAppendingFormat:@"%@ :\n", key];
            spaceIndent++;
            return [obj traverseTree:string key:key2 obj:[[obj objectForKey:key] objectForKey:key2]];
        }
        
    } else if ( [obj respondsToSelector:@selector(arrayWithArray:)] ) {
        for ( id key2 in [[obj objectForKey:key] allKeys] ) {
            string = [string stringByAppendingFormat:@"%@ :\n", key];
            spaceIndent++;
            return [obj traverseTree:string key:key2 obj:obj];
        }
    } else {
        for ( int i = 0; i < spaceIndent; i++ ) {
            string = [string stringByAppendingString:@" "];
        }
        return [string stringByAppendingFormat:@"%@\n", key];
    }
    

}



- (int)hasChildren:(NSString *)key {
    
    id val = [self objectForKey:key];
    if ( nil == val ) {
        return 0;
    }
    NSString *class = NSStringFromClass([val class]);
    if ( nil == class ) {
        return 0;
    }
    int success = ( [class containsString:@"Dictionary"] ||
                    [class containsString:@"Array"] );
    
    return success;
    
}

@end
