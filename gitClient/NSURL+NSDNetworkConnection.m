//
//  NSURL+NSDGitNetworkConnection.m
//  gitClient
//
//  Created by NullStackDev on 24.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSURL+NSDNetworkConnection.h"

@implementation NSURL (NSDGitNetworkConnection)

- (NSDictionary *)dictionaryFromURL{
    NSString * queryString = [self query];
    NSArray * stringPairs = [queryString componentsSeparatedByString:@"&"];
    NSMutableDictionary * keyValuePairs = [NSMutableDictionary new];
    
    for(NSString * pair in stringPairs){
        NSArray * bits = [pair componentsSeparatedByString:@"="];
        if(bits.count>1){
            NSString * key = [(NSString *)[bits objectAtIndex:0] stringByRemovingPercentEncoding ] ;
            NSString * value = [(NSString *)[bits objectAtIndex:1] stringByRemovingPercentEncoding] ;
            [keyValuePairs setObject:value forKey:key];
        }
    }
    
    return keyValuePairs;
}

@end
