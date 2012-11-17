//
//  OBJCReturnTypes.h
//  ParseMaster
//
//  Created by Miles Alden on 10/21/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSDictionaryAdditions.h"

@interface FiR3FiOBJCReturnTypes : NSObject


+ (NSDictionary *)returnTypesDictionary;
+ (NSDictionary *)returnTypesFromHumanKeys;
+ (const char *)returnTypeForKey: (NSString *)key;
+ (NSString *)returnTypeAsStringForKey: (NSString *)key;


@end
