//
//  NSStringContains.m
//  
//
//  Created by Miles Alden on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PSStringContains.h"

@implementation NSString (PSStringContains)

- (BOOL)containsString: (NSString *)string
{
    // Could also do regex
    // Like this:
    // NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:key
    //                                                                          options:NSRegularExpressionCaseInsensitive
    //                                                                            error:&error];
    // int matches = [regex numberOfMatchesInString:self options:options:NSRegularExpressionCaseInsensitive range:[self range]];
    // return ( matches );
    
    BOOL retVal;
    NSRange range = [self rangeOfString:string];
    if ( range.length < 1 ) retVal = NO;
    else retVal = YES;
    
    return retVal;
}

- (BOOL)containsInsensitiveString: (NSString *)string
{
    // This could be very bad
    // with large strings.
    BOOL retVal;
    NSRange range = [[self lowercaseString] rangeOfString:[string lowercaseString]];
    if ( range.length < 1 ) retVal = NO;
    else retVal = YES;
    
    return retVal;
}


- (NSRange)range {
    return NSMakeRange(0, self.length);
}

@end
