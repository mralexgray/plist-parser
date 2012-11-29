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
#import "PSYAMLParser.h"

#define COLOR CANTALOUPE



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
 
    PSYAMLParser *yaml = [[PSYAMLParser alloc] init];
    return [yaml parseDictToYAML:self];    
}


@end
