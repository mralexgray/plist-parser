//
//  PSParseObject.h
//  Plister
//
//  Created by Miles Alden on 11/17/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import "PSObject.h"
#import "JSONKit.h"

@interface PSParseObject : PSObject

@property (strong) NSString *str;
@property (strong) NSString *path;
@property (strong) NSString *xmlPath;
@property (strong) NSData *data;

- (NSString *)JSON;
- (NSString *)YAML;
- (NSString *)XML;
- (NSString *)binary;
- (NSDictionary *)dictionary;
- (id)initWithData:(NSData *)dataBytes;
- (id)initWithPath:(NSString *)pathName;

@end
