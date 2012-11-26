//
//  PSParseObject.m
//  Plister
//
//  Created by Miles Alden on 11/17/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import "PSParseObject.h"
#define COLOR LIGHT_PURPLE

@implementation PSParseObject

- (id)init {
    
    if ( self = [super init] ) {
        // Initial stuff
    }
    
    return self;
}

- (id)initWithPath:(NSString *)pathName {
    
    if ( self = [super init] ) {
        // Initial stuff
        if ( nil != pathName ) {
            self.path = pathName;
            [self buildToString];
        }
    }
    
    return self;
    
}

- (id)initWithData:(NSData *)dataBytes {
    
    if ( self = [super init] ) {
        // Initial stuff
        if ( nil != dataBytes ) {
            self.data = dataBytes;
            [self buildToString];
        }
    }
    
    return self;
    
}


- (NSString *)JSON {
    return [NSJSONSerialization JSONObjectWithData:<#(NSData *)#> options:<#(NSJSONReadingOptions)#> error:<#(NSError *__autoreleasing *)#> ];
}

- (NSString *)YAML {
    
}

- (NSString *)XML {
    return self.str;
}

- (NSString *)binary {
    
}

- (NSDictionary *)dictionary {
    
    // Build a dictionary
    NSError *err;
    id result = [NSPropertyListSerialization propertyListWithData:self.data
                                                          options:NSPropertyListImmutable
                                                           format:NULL
                                                            error:&err];
    if ( err ) {
        Log(@"Error: %@", err);
        return nil;
    }
    
    return result;
}


- (NSString *)copyFile {
    
    if ( nil == self.path ) {
        Log(@"No path.");
        return nil;
    } else if ( self.data ) {
        
    }
    
    // Build command
    NSString *ext = [NSString stringWithFormat:@".%@", [self.path pathExtension]];
    NSString *newPath = [self.path stringByReplacingOccurrencesOfString:ext
                                                             withString:[NSString stringWithFormat:@"_xml%@", ext]];
    NSString *command = [NSString stringWithFormat:@"cp %@ %@", self.path, newPath];
    const char *cmd = [command cStringUsingEncoding:NSASCIIStringEncoding];
    
    // shell command
    if ( (system( cmd )) ) {
        Log(@"Fail");
        return nil;
    }
    
    return newPath;
}


- (void)convertToXML_plist:(NSString *)path {
    
    // Convert to xml
    NSString *command = [NSString stringWithFormat:@"plutil -convert xml1 %@", path];
    const char *cmd = [command cStringUsingEncoding:NSASCIIStringEncoding];
    if ( (system( cmd )) ) {
        Log(@"Fail");
        return;
    }
}

- (void)convertToJSON_plist:(NSString *)path {
    
    // Convert to JSON
    NSString *command = [NSString stringWithFormat:@"plutil -convert json %@", path];
    const char *cmd = [command cStringUsingEncoding:NSASCIIStringEncoding];
    if ( (system( cmd )) ) {
        Log(@"Fail");
        return;
    }

}

- (void)buildToString {
    
    self.xmlPath = [self copyFile];
    [self convertToXML_plist:self.xmlPath];
    
    if ( nil == self.data ) {
        self.data = [NSData dataWithContentsOfFile:self.xmlPath];
    }
    
    self.str = [[NSString alloc] initWithBytes:[self.data bytes]
                                        length:[self.data length]
                                      encoding:NSUTF8StringEncoding];
}


@end
