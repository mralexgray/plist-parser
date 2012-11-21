//
//  PSTimer.m
//  
//
//  Created by Miles Alden on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PSTimer.h"

@implementation PSTimer

- (id) init {
    self = [super init];
    if (self != nil) {
        start = 0;
        end = 0;
    }
    return self;
}

- (void) startTimer {
    start = CFAbsoluteTimeGetCurrent();
}

- (void) stopTimer {
    end = CFAbsoluteTimeGetCurrent();
}

- (double) timeElapsedInSeconds {
    return end - start;
}

- (double) timeElapsedInMilliseconds {
    return [self timeElapsedInSeconds] * 1000;
}

- (double) timeElapsedInMinutes {
    return [self timeElapsedInSeconds] / 60.0f;
}


@end
