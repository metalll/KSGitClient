//
//  NSDReachability.h
//  gitClient
//
//  Created by NullStackDev on 23.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

typedef enum {
    NotReachable = 0,
    Reachable,
} NetworkStatus;



@interface NSDReachability : NSObject{
    SCNetworkReachabilityRef reachabilityRef;
}



- (NetworkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags;
- (NetworkStatus)currentReachabilityStatus;

@end
