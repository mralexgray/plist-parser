//
//  ParseMaster.h
//  ParseMaster
//
//  Created by Miles Alden on 10/21/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FiR3FiOBJCReturnTypes.h"



@interface FiR3FiParseMaster : NSObject {
    
}

@property (nonatomic, strong) NSString *dataType;
@property (nonatomic, strong) NSData   *ptrAsData;


- (NSString *)parsePrimitive: (NSError **)error;
- (NSString *)parsePrimitiveWithData: (NSData *)data error:(NSError **)error;
- (NSString *)parsePrimitiveWithData: (NSData *)data andType:(NSString *)dType error:(NSError **)error;

- (void)setData: (NSData *)data;
- (void)setDType: (NSString *)dType;
- (void)setData: (NSData *)data andType: (NSString *)dType;

- (BOOL)returnsPrimitive: (SEL)selector obj:(id)obj;

@end
