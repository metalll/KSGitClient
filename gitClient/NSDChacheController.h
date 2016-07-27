//
//  NSDChacheController.h
//  gitClient
//
//  Created by NullStackDev on 24.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDChacheController : NSObject
+ (void)objectForKey:(id)key andCompletion:(void(^)(id object))completion;
+ (void)setObject:(id)object forKey:(id<NSCopying>)key ofLength:(NSUInteger)length;
@end
