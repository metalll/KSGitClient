//
//  NSDictionary+NSDGitNetworkConnection.m
//  gitClient
//
//  Created by NullStackDev on 24.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDictionary+NSDNetworkConnection.h"

@implementation NSDictionary (NSDGitNetworkConnection)
-(NSString *)encodedStringWithHttpBody{

   
    NSMutableArray * partsArray = [NSMutableArray new];
    
    for(NSString * key in self.allKeys){
       
            NSString * keyArr = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
            
            NSString * valueArr = [[self valueForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
            
            [partsArray addObject:[[(NSString *)keyArr stringByAppendingString: @"="]stringByAppendingString:(NSString *)valueArr]] ;
       
            }
            
        
        return [partsArray componentsJoinedByString:@"&"];
        
    }
    
@end
