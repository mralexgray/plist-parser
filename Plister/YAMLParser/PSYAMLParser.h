//
//  PSYAMLParser.h
//  Plister
//
//  Created by Miles Alden on 11/29/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSYAMLParser : NSObject {
    
    
    NSString *string;
    int spaceIndent;
    int indentModifier;
    char chars[300];
    int decrementSpaces;

}

- (NSString *)parseDictToYAML:(NSDictionary *)dict;

@end
