//
//  NSDNewsRssEntry.h
//  gitClient
//
//  Created by NullStackDev on 07.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDNewsRssEntry : NSObject
@property NSString * content;
@property NSString * published;
@property NSString * type;
@property NSString * link;
@property NSString * authorAvatarUrl;

- (id)initWithDictinary:(NSDictionary *)dictionary andIndex:(NSInteger)index;

@end
