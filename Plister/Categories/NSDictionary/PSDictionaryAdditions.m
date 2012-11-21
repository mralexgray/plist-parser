//
//  NSDictionary+SettingsDictionaries.m
//  
//
//  Created by Miles Alden on 8/7/12.
//
//

#import "PSDictionaryAdditions.h"
#import "PSArrayAdditions.h"

@implementation NSDictionary (SettingsDictionaries)

- (BOOL)containsKey: (NSString *)key {
    
    // Could also do this:
    // return (nil != [self objectForKey:key]);
    
    BOOL retVal = 0;
    NSArray *allKeys = [self allKeys];
    retVal = [allKeys containsObject:key];
    return retVal;
    
}


@end
