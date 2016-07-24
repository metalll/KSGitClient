//
//  NSDGitNetworkConnection.h
//  gitClient
//
//  Created by NullStackDev on 23.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDGitRequestType.h"
#import "NSDGitResponseType.h"
@interface NSDGitNetworkConnection : NSURLConnection

    +(void)asyncRequest:(NSURLRequest *)request success:(id(^)(NSData *, NSURLResponse *))successBlock;
    +(void)asyncRequest:(NSURLRequest *)request success:(id(^)(NSData *, NSURLResponse *))successBlock failure:(id(^)(NSError *))failureBlock_;




@end
