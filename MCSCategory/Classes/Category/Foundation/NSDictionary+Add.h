//
//  NSDictionary+UU.h
//  UU
//
//  Created by Frank on 2019/2/18.
//  Copyright © 2019年 DJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Add)

/**
 Returns a new array containing the dictionary's keys sorted.
 The keys should be NSString, and they will be sorted ascending.
 
 @return A new array containing the dictionary's keys,
 or an empty array if the dictionary has no entries.
 */
- (NSArray *)allKeysSorted;

/**
 Returns a new array containing the dictionary's values sorted by keys.
 
 The order of the values in the array is defined by keys.
 The keys should be NSString, and they will be sorted ascending.
 
 @return A new array containing the dictionary's values sorted by keys,
 or an empty array if the dictionary has no entries.
 */
- (NSArray *)allValuesSortedByKeys;
- (NSString *)jsonStringEncoded;
@end
