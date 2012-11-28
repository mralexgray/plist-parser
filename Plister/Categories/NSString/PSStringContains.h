//
//  PSStringContains
//  
//
//  Created by Miles Alden on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PSStringContains)

- (BOOL)containsString: (NSString *)string;
- (BOOL)containsInsensitiveString: (NSString *)string;
- (NSRange)range;


@end
