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

@implementation NSDictionary (SettingsDictionaries)

- (BOOL)containsKey: (NSString *)key {
    
    // Could also do this:
    // return (nil != [self objectForKey:key]);
    
    BOOL retVal = 0;
    NSArray *allKeys = [self allKeys];
    retVal = [allKeys containsObject:key];
    return retVal;
    
}


- (NSString *)YAMLstring {
    
    NSMutableString *string = [NSMutableString stringWithString:@"\n"];
    int spaceCount = 0;
    for ( id key in [self allKeys] ) {
        if ( [self hasChildren:key] ) {
            [string appendFormat:@"%@\n", key];
            spaceCount++;
            
        
        } else {
            for ( int i = 0; i < spaceCount; i++) {
                [string appendString:@" "];
            }
            [string appendFormat:@"%@\n", key];
            
        }
    }
    
    return string;
    
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
