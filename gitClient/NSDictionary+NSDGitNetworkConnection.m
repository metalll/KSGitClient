//
//  NSDictionary+NSDGitNetworkConnection.m
//  gitClient
//
//  Created by NullStackDev on 24.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDictionary+NSDGitNetworkConnection.h"

@implementation NSDictionary (NSDGitNetworkConnection)
-(NSString *)encodedStringWithHttpBody:(NSString *)stringHttpBody{

   
    NSMutableArray * partsArray = [NSMutableArray new];
    
    for(NSString * key in self){
        if([[self valueForKey:key] isKindOfClass:[NSString class]]){
            NSString * keyArr = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
            
            NSString * valueArr = [[self valueForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
            
            [partsArray addObject:[[(NSString *)keyArr stringByAppendingString: @"="]stringByAppendingString:(NSString *)valueArr]] ;
        }
            else {
                return nil;
            }
            
        
        return [partsArray componentsJoinedByString:@"&"];
        
    }
    
    return nil;
}
@end
