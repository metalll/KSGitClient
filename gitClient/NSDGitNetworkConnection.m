//
//  NSDGitNetworkConnection.m
//  gitClient
//
//  Created by NullStackDev on 23.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDGitNetworkConnection.h"
#import "NSDGitNetworkController_Private.h"
#import "NSDGitConstants.h"



@implementation NSDGitNetworkConnection


+(NSDictionary *)sharedInstance{
    static dispatch_once_t oncePredicate;
    static NSString * baseURL;
    static __weak NSURLSession * urlSession;
    static NSString * token;
    dispatch_once(&oncePredicate, ^{
        baseURL = kGithubAPIURL;
        urlSession = [NSURLSession sharedSession];
        token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    });
    token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    NSMutableDictionary * retVal = [NSMutableDictionary new];
    [retVal setObject:baseURL forKey:@"baseURL"];
    [retVal setObject:urlSession forKey:@"urlSession"];
    [retVal setObject:token forKey:@"token"];
    return retVal;
}










@end
