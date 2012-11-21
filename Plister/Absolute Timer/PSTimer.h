//
//  PSTimer.h
//  
//
//  Created by Miles Alden on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSTimer : NSObject {
    
    double start;
    double end;
}

- (void) startTimer;
- (void) stopTimer;
- (double) timeElapsedInSeconds;
- (double) timeElapsedInMilliseconds;
- (double) timeElapsedInMinutes;


@end
