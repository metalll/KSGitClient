//
//  NSDRepo.h
//  gitClient
//
//  Created by NullStackDev on 27.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDRepo : NSObject
@property NSString * repoName;
@property BOOL isFork;
@property NSString * stars;
@property NSString * repoUrl;
@property NSString * forks;
@end
