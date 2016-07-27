//
//  NSDGitManager_Private.h
//  gitClient
//
//  Created by NullStackDev on 25.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDGitManager.h"

@interface NSDGitManager ()
+(NSString *)URLStringWithPathComponent:(NSString *)pathComponent;
+(void)searchForPath:(NSString *)path andQueryString:(NSString *)query andCompletion:(void(^)(NSDictionary * responceDic,NSString * errorString))completion;


@end
