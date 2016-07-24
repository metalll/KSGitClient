//
//  NSDReachability.m
//  gitClient
//
//  Created by NullStackDev on 23.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDReachability.h"
#import "NSDGitConstants.h"
#import <SystemConfiguration/SystemConfiguration.h>
@implementation NSDReachability



static void reachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSDGithubReachabilityStatusDidChangeNotification object:(__bridge NSDictionary *)info];
}


- (void)dealloc
{
    if (reachabilityRef != NULL)
    {
        CFRelease(reachabilityRef);
    }
}


- (id)init
{
    if ((self = [super init]))
    {
        reachabilityRef = SCNetworkReachabilityCreateWithName(NULL, [@"www.github.com" UTF8String]);
        SCNetworkReachabilityContext context = {0, (__bridge void *)(self), CFRetain, CFRelease, NULL};
        SCNetworkReachabilitySetCallback(reachabilityRef, reachabilityCallback, &context);
        SCNetworkReachabilityScheduleWithRunLoop(reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    }
    
    return self;
}

- (NetworkStatus)currentReachabilityStatus
{
    SCNetworkReachabilityFlags flags;
    return (SCNetworkReachabilityGetFlags(reachabilityRef, &flags) && (flags & kSCNetworkReachabilityFlagsReachable) && !(flags & kSCNetworkReachabilityFlagsConnectionRequired));
}


- (NetworkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags
{
    return (flags & kSCNetworkReachabilityFlagsReachable) && !(flags & kSCNetworkReachabilityFlagsConnectionRequired);
}




@end
