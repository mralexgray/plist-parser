//
//  NSObject+ClassName.m
//  
//
//  Created by Miles Alden on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSObject+ClassName.h"
#import <objc/runtime.h>

#import "FiR3FiOBJCReturnTypes.h"

@implementation NSObject (ClassName)


- (int)isContainerClass {
    
    if ( [self isKindOfClass:NSClassFromString(@"NSDictionary")] ||
        [self isKindOfClass:NSClassFromString(@"NSArray")]) {
        return 1;
    }
    
    return 0;
}

- (int)isDictionary {
    if ( [self isKindOfClass:NSClassFromString(@"NSDictionary")]) {
        return 1;
    }
    return 0;
}

- (int)isArray {
    if ( [self isKindOfClass:NSClassFromString(@"NSArray")]) {
        return 1;
    }
    return 0;
}



- (NSString *)className {
    
    return NSStringFromClass([self class]);
}


- (NSMutableArray *)properties {
    
    // Returns an array of the propery names.
    unsigned int outCount;
    
    objc_property_t *propArray = class_copyPropertyList([self class], &outCount);
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < outCount; i++ ) {
        const char *propertyName = property_getName(propArray[i]);
        [array addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    
    return array;
    
}

- (NSMutableArray *)methods {
    
    
    // TODO: This doesn't quite give accurate return values...
    NSDictionary *returnValues = [FiR3FiOBJCReturnTypes returnTypesDictionary];
    
    // Returns an array of the propery names.
    unsigned int outCount;
    
    Method *methodArray = class_copyMethodList([self class], &outCount);
    
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < outCount; i++ ) {
        
        
        // Method name
        SEL methodSEL = method_getName(methodArray[i]);
        NSString *methodName = [NSMutableString stringWithString:NSStringFromSelector(methodSEL)];
        
        // Class or instance type
        // TODO: broken
        BOOL isClassType = class_isMetaClass(object_getClass(self));
        NSString *prefix = ( isClassType ) ? @" + " : @" - ";
        
        // Return type
        char *rType = method_copyReturnType(methodArray[i]);
        NSString *returnType = [NSString stringWithCString:rType encoding:NSUTF8StringEncoding];
        
        
        // Arg types
        unsigned int numArgs = method_getNumberOfArguments(methodArray[i]);
        char * argType[numArgs];
        int counter = 0;
        for ( int m = 2; m < numArgs; m++ ) {
            
            // Skip self & _cmd
            argType[counter] = method_copyArgumentType(methodArray[i], m);
            counter++;
        }
        
        // Break it down and remove
        // any extra trailing spaces
        NSMutableArray *components = [[NSMutableArray alloc] initWithArray:[methodName componentsSeparatedByString:@":"]];
        for ( int n = 0; n < components.count; n++ ) {
            NSString *item = [components objectAtIndex:n];
            if ( [item isEqualToString:@""] ) {
                [components removeObject:item];
            }
        }
        
        // Get return type from Dictionary or
        // raw type if struct, etc.
        NSString *retHumanReadable;
        NSString *retStore = [returnValues objectForKey:returnType];
        if ( returnType.length > 1 ) {
            retHumanReadable = returnType;
        } else {
            retHumanReadable = retStore;
        }
        
        
        // Insert return type, starting bracket
        // and class/instance prefix
        NSMutableString *editedMethodNameString = [[NSMutableString alloc] init];
        [editedMethodNameString insertString:[NSString stringWithFormat:@"(%@) [", retHumanReadable] atIndex:0];
        [editedMethodNameString insertString:prefix atIndex:0];
        [editedMethodNameString appendFormat:@"%@ ", NSStringFromClass([self class])];
        
        
        for ( int p = 0; p < components.count; p++ ) {
            
            NSString *stringPiece = [[NSString alloc] initWithString:[components objectAtIndex:p]];
            
            // Add it back in with new info
            NSString *argTypeAsNSString = [NSString stringWithCString:argType[p] encoding:NSUTF8StringEncoding];
            NSString *retValFromDict;
            
            // C Structs and things give us their
            // names, so let's keep them if we can.
            // In theory, > 1 length means it's a struct
            // or something like it.
            if ( argTypeAsNSString.length > 1 ) {
                retValFromDict = argTypeAsNSString;
            } else {
                retValFromDict = [returnValues objectForKey:argTypeAsNSString];
            }
            
            if ( numArgs > 2 ) {
                [editedMethodNameString appendFormat:@" %@:(%@)arg%d", stringPiece, retValFromDict, p];
            } else {
                [editedMethodNameString appendFormat:@" %@", stringPiece];
            }
            
        }
        
        // Closing bracket
        [editedMethodNameString appendString:@"]"];
        
        
        [array addObject:editedMethodNameString];
    }
    
    return array;
    
}

- (NSMutableArray *)ivars {
    
    // Returns an array of the ivar names.
    unsigned int outCount;
    
    Ivar *ivarArray = class_copyIvarList([self class], &outCount);
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < outCount; i++ ) {
        const char *ivarName = ivar_getName(ivarArray[i]);
        [array addObject:[NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding]];
    }
    
    return array;
    
    
}
@end
