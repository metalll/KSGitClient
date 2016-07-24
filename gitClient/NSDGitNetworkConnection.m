//
//  NSDGitNetworkConnection.m
//  gitClient
//
//  Created by NullStackDev on 23.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDGitNetworkConnection.h"
#import "NSDGitRequestType.h"
#import "NSDGitResponseType.h"



@implementation NSDGitNetworkConnection



+ (void)asyncRequest:(NSURLRequest *)request success:(id(^)(NSData *, NSURLResponse *))successBlock failure:(id(^)(NSError *))failureBlock_
{
    
   
        NSLog(@"%@ to request : %@", request.HTTPMethod, request);
        
      
        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (error!=nil) {
                    failureBlock_(error);
                }
                else {
                    successBlock(data,response);
                }

            });
            
        
            
            
        }
        
    ] resume];


    
    
   
}


+ (void)asyncRequest:(NSURLRequest *)request success:(id(^)(NSData *, NSURLResponse *))successBlock
{
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error!=nil) {
                return ;
                      }
            else{
                successBlock(data,response);
            }
  
        });
        
        
        
        
        
    }
     
     ] resume];
    
    
    
}









@end
