//
//  NSDictionary+SettingsDictionaries.h
//  
//
//  Created by Miles Alden on 8/7/12.
//
//

#import <Foundation/Foundation.h>

#define PSNoKey @"-111"

@interface NSDictionary (SettingsDictionaries)

- (BOOL)containsKey: (NSString *)key;
- (int)hasChildren:(NSString *)key;
- (NSString *)YAMLstring;

@end
