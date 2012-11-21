//
//  PSParseManager.h
//  Plister
//
//  Created by Miles Alden on 11/17/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import "PSObject.h"
#import "PSParseObject.h"

@interface PSParseManager : PSObject


@property (strong) PSParseObject *parseObject;
@property (strong) NSString *elementName;
@property (strong) NSArray *matches;
@property (strong) NSMutableString *strEdits, *output;
@property (strong) NSMutableArray *elements;
@property int numIndents;


- (void)beginParseIterations;
- (void)parseBetter;
- (NSString *)getValueWithTweenRange:(NSRange)start end:(NSRange)end;
- (NSRange)getTweenRange:(NSRange)start end:(NSRange)end;
- (void)addNewlinesAt: (NSString *)location;

@end
