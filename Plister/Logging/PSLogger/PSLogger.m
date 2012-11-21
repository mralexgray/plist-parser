//
//  PSLog.m
//  PS
//
//  Created by Miles Alden on 8/7/12.
//
//

#import "PSLogger.h"
#import "PSColorLogging.h"



@implementation PSLogger

void PSLog(NSString *format,...) {
    
    va_list ap;
    va_start (ap, format);
    if (![format hasSuffix: @"\n"]) {
        format = [format stringByAppendingString: @"\n"];
    }
    NSString *body =  [[NSString alloc] initWithFormat: format arguments: ap];
    
    
    va_end (ap);
    fprintf(stderr, "%s",[body UTF8String]);
}


@end
