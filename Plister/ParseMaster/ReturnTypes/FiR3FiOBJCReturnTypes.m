//
//  OBJCReturnTypes.m
//  ParseMaster
//
//  Created by Miles Alden on 10/21/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import "FiR3FiOBJCReturnTypes.h"

@implementation FiR3FiOBJCReturnTypes


// Sugar
+ (NSString *)returnTypeAsStringForKey: (NSString *)key {
    
    return [NSString stringWithCString:[self returnTypeForKey:key] encoding:NSUTF8StringEncoding];
    
}


+ (const char *)returnTypeForKey: (NSString *)key {
    
    // Check if the guy gave us the
    // human form of the type, and if the key exists
    NSDictionary *comparingDict = [FiR3FiOBJCReturnTypes returnTypesFromHumanKeys];
    if ( [comparingDict containsKey:key] ) {
        return [[comparingDict objectForKey:key] cStringUsingEncoding:NSUTF8StringEncoding];
    }
    
    // Check if the guy gave us the ObjC
    // encoding of the type, and if the key exists
    comparingDict = [FiR3FiOBJCReturnTypes returnTypesDictionary];
    if ( [comparingDict containsKey:key] ) {
        return [[comparingDict objectForKey:key] cStringUsingEncoding:NSUTF8StringEncoding];
    }
    
    // If neither case occurs return NULL
    return NULL;
    
}


+ (NSDictionary *)returnTypesFromHumanKeys {
    
    return @{
    
            //KEY                        // OBJ
            // scalar types
            @"int":                      @"i",
            @"short":                    @"s",
            @"long":                     @"l",
            @"long long":                @"q",
            @"unsigned char":            @"C",
            @"unsigned int":             @"I",
            @"unsigned short":           @"S",
            @"unsigned long":            @"L",
            @"unsigned long long":       @"Q",
            @"float":                    @"f",
            @"double":                   @"d",
            
            // char & char *
            @"char":                     @"c",
            @"char *":                   @"*",
            
            // bool
            @"bool":                     @"B",
            
            // void
            @"void":                     @"v",
            
            // Objects
            @"object":                   @"@",
            @"class object":             @"#",
            
            // Selector
            @"selector":                 @":",
            
            // Multiple value items
            @"array":                    @"[]",
            @"struct":                   @"{}",
            @"union":                    @"()",
            
            // Pointer to type
            @"pointer":                  @"^",
            
            
            @"bit field":                @"b",
            @"unknown":                  @"?" };
    
}

+ (NSDictionary *)returnTypesDictionary {
    
    NSMutableDictionary *valDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   
                                   
                                   // OBJ                       // KEY
                                   // scalar types
                                   @"int",                      @"i",
                                   @"short",                    @"s",
                                   @"long",                     @"l",
                                   @"long long",                @"q",
                                   @"unsigned char",            @"C",
                                   @"unsigned int",             @"I",
                                   @"unsigned short",           @"S",
                                   @"unsigned long",            @"L",
                                   @"unsigned long long",       @"Q",
                                   @"float",                    @"f",
                                   @"double",                   @"d",
                                   
                                   // char & char *
                                   @"char",                     @"c",
                                   @"char *",                   @"*",
                                   
                                   // bool
                                   @"c++ bool or c99 _Bool",    @"B",
                                   
                                   // void
                                   @"void",                     @"v",
                                   
                                   // Objects
                                   @"object",                   @"@",
                                   @"class object",             @"#",
                                   
                                   // Selector
                                   @"selector",                 @":",
                                   
                                   // Multiple value items
                                   @"array",                    @"[]",
                                   @"structure",                @"{}",
                                   @"union",                    @"()",
                                   
                                   // Pointer to type
                                   @"pointer to type",          @"^",
                                   
                                   
                                   @"bit field of x-num bits",  @"b",
                                   @"unknown type",             @"?"
                                   ,nil];
    
    return [NSDictionary dictionaryWithDictionary:valDic];
    
}

@end
