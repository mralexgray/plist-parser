//
//  NSArray+PSArrayAdditions.m
//  
//
//  Created by Miles Alden on 8/7/12.
//
//

#import "PSArrayAdditions.h"
#import "PSDictionaryAdditions.h"

@implementation NSArray (PSArrayAdditions)


- (int)isIndexValid:(int)index {
    return ((index < self.count) && (index > -1));
}


@end
