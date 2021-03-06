//
//  NSDNetworkController.m
//  gitClient
//
//  Created by NullStackDev on 25.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDNetworkController.h"
#import "NSDGitConstants.h"
#import "NSDictionary+NSDNetworkConnection.h"
#import "NSMutableURLRequest+NSDNetworkConnection.h"
#import <UIKit/UIKit.h>
@implementation NSDNetworkController




- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlSession = nil;
        self.baseURL = kGithubURL;
        self.token = nil;
    }
    return self;
}



-(NSString *)processResponceWithResponce:(NSURLResponse *)responce andError:(NSError *)error{
    if(error){
        return [error localizedDescription];
    }
    
    NSHTTPURLResponse * httpResponce = (NSHTTPURLResponse *)responce;
   // NSLog(@"%@",responce);
    if(httpResponce.statusCode>=200&&httpResponce.statusCode<=299){ return nil; }
    if(httpResponce.statusCode>=400&&httpResponce.statusCode<=499){ return [NSString stringWithFormat:@"Client error: %d",httpResponce.statusCode]; }
    if(httpResponce.statusCode>=500&&httpResponce.statusCode<=599){ return [NSString stringWithFormat:@"Server error: %d",httpResponce.statusCode]; }
    
    return [NSString stringWithFormat:@"Unknown error: %d",httpResponce.statusCode];
}

-(void)downloadResourceWithURLString:(NSString *)url andCompletion:(void (^)(NSString * localPath, NSString * errorString))completion{
    NSURL * URL = [NSURL URLWithString:url];
    NSURLRequest * request = [NSURLRequest requestWithURL:URL cachePolicy: NSURLRequestUseProtocolCachePolicy  timeoutInterval:10];
    NSURLSession * session = self.urlSession;
    [[session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error){

            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,[self processResponceWithResponce:response andError:error]);
            });
            return ;
        }
        
        if(!location){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,@"Error!Request succeed, but URL is nil!");
            });
            return ;
        }
        
        NSString * localPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSUUID UUID].UUIDString];
        NSError * errorF;
        [[NSFileManager defaultManager] copyItemAtURL:location toURL:[NSURL fileURLWithPath:localPath] error:&errorF];
        if(errorF){
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,[NSString stringWithFormat:@"could don't copy downloaded file %@",[error localizedDescription]]);
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion([NSString stringWithFormat:@"%@",location],nil);
        });
        
        
    }] resume];
    
}

-(void)performRequestWithURLPath:(NSString *)urlPath andMethod:(NSString *)method andParams:(NSDictionary *)params andAcceptJSONResponse:(BOOL)acceptJSONResponse andSendBodyAsJSON:(BOOL)sendBodyAsJSON andCompletion:(void (^)(NSData *, NSString *))completion{
    NSString * baseURL =[NSString stringWithFormat:@"%@", self.baseURL];
    if(baseURL){
        [self performRequestWithURLString:[baseURL stringByAppendingPathComponent:urlPath] andMethod:method andParams:params andAcceptJSONResponse:acceptJSONResponse andSendBodyAsJSON:sendBodyAsJSON andCompletion:completion];
    }else{
        completion(nil,@"baseURL not set");
    }
    
}

-(void)performRequestWithURLString:(NSString *)url andMethod:(NSString *)method andParams:(NSDictionary *)params andAcceptJSONResponse:(BOOL)acceptJSONResponse andSendBodyAsJSON:(BOOL)sendBodyAsJSON andCompletion:(void (^)(NSData *, NSString *))completion{
    
    NSURL * URL = [NSURL URLWithString:url];
    
    if(!method){
        method = @"GET";
    }
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    request.HTTPMethod = method;
    
    if(acceptJSONResponse){
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSLog(@"%@",request.HTTPBody) ;
    }
    
    if(params){
        if([method isEqualToString:@"POST"]||[method isEqualToString:@"PUT"]||[method isEqualToString:@"DELETE"]||[method isEqualToString:@"PATH"]){
        
            NSData * bodyData = nil;
            if(sendBodyAsJSON){
                NSError * JSONError  = nil;
                
                request.HTTPBody = [NSJSONSerialization dataWithJSONObject:params options:0 error:&JSONError];
                
                if(JSONError){
                    completion(nil,[@"Error dataWithJSON" stringByAppendingString:[JSONError localizedDescription]]);
                    return;
                }else{
                    NSString * encodedString = [params encodedStringWithHttpBody];
                    bodyData = [encodedString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
                    if(!bodyData){
                        completion(nil,@"couldn't create bodyData");
                        return;
                    }
                    
                    [request setBodyData:bodyData isJSONData:sendBodyAsJSON];
                    
                }
                
                
            }
            
        }
    }
    else {
            NSString * encodedString = [params encodedStringWithHttpBody];
            NSURL * reqURL;
            if(encodedString)
            reqURL = [NSURL URLWithString:[[url stringByAppendingString:@"?"]stringByAppendingString:  encodedString]];
            else reqURL=[NSURL URLWithString:url];
            request.URL = reqURL;
    }
    
    if(!self.urlSession) [self setUrlSession:[NSURLSession sharedSession]];
    [[self.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
              NSString * errorString = [self processResponceWithResponce:response andError:error];
                if(errorString!=nil){
                    completion(data,errorString);
                    return ;
                }
                if(data == nil){
                    completion(nil,@"no data, no life ;-( ");
                }
                
                completion(data,nil);
                
                
            });
            
        }] resume];
   
    
}

@end
