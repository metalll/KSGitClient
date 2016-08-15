//
//  NSDNotification.h
//  gitClient
//
//  Created by NullStackDev on 14.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDNotification : NSObject
@property NSString * firstTitle;
@property NSString * updatedAt;
@property NSString * authorAvatarUrl;
@property NSString * type;
@property NSString * typeTitle;
@property NSString * notifURL;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary andIndex:(NSInteger) index;

@end
