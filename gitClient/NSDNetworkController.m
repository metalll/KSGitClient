//
//  NSDNetworkController.m
//  gitClient
//
//  Created by NullStackDev on 25.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDNetworkController.h"
#import "NSDNetworkController_Private.h"
#import "NSDGitConstants.h"
#import "NSDictionary+NSDNetworkConnection.h"
#import "NSMutableURLRequest+NSDNetworkConnection.h"
@implementation NSDNetworkController


+(NSDictionary *)sharedInstance{
    static dispatch_once_t oncePredicate;
    static NSString * baseURL;
    static __weak NSURLSession * urlSession;
    static NSString * token;
    dispatch_once(&oncePredicate, ^{
        baseURL = kGithubURL;
        urlSession = [NSURLSession sharedSession];
    });
    token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    NSMutableDictionary * retVal = [NSMutableDictionary new];
    [retVal setObject:baseURL forKey:@"baseURL"];
    [retVal setObject:urlSession forKey:@"urlSession"];
    [retVal setObject:token forKey:token];
    
    return retVal;
}




+(NSString *)processResponceWithResponce:(NSURLResponse *)responce andError:(NSError *)error{
    if(error!=nil){
        return [error localizedDescription];
    }
    
    NSHTTPURLResponse * httpResponce = (NSHTTPURLResponse *)responce;
    
    if(httpResponce.statusCode>=200&&httpResponce.statusCode<=299){ return nil; }
    if(httpResponce.statusCode>=400&&httpResponce.statusCode<=499){ return [NSString stringWithFormat:@"Client error: %lu",httpResponce.statusCode]; }
    if(httpResponce.statusCode>=500&&httpResponce.statusCode<=599){ return [NSString stringWithFormat:@"Server error: %lu",httpResponce.statusCode]; }
    
    return [NSString stringWithFormat:@"Unknown error: %lu",httpResponce.statusCode];
}

+(void)downloadResourceWithURLString:(NSString *)url andCompletion:(void (^)(NSString * localPath, NSString * errorString))completion{
    NSURL * URL = [NSURL URLWithString:url];
    NSURLRequest * request = [NSURLRequest requestWithURL:URL cachePolicy: NSURLRequestUseProtocolCachePolicy  timeoutInterval:10];
    NSURLSession * session = [[self sharedInstance] objectForKey:@"urlSession"];
    [[session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error){

            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,[self processResponceWithResponce:response andError:error]);
            });
            return ;
        }
        
        if(location==nil){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,@"Error!Request succeed, but URL is nil!");
            });
            return ;
        }
        
        NSString * localPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSUUID UUID].UUIDString];
        NSError * errorF;
        [[NSFileManager defaultManager] copyItemAtURL:location toURL:[NSURL fileURLWithPath:localPath] error:&errorF];
        if(errorF!=nil){
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

+(void)performRequestWithURLPath:(NSString *)urlPath andMethod:(NSString *)method andParams:(NSDictionary *)params andAcceptJSONResponse:(BOOL)acceptJSONResponse andSendBodyAsJSON:(BOOL)sendBodyAsJSON andCompletion:(void (^)(NSData *, NSString *))completion{
    NSString * baseURL =[[self sharedInstance]objectForKey:@"baseURL"];
    if(baseURL){
        [self performRequestWithURLString:[baseURL stringByAppendingPathComponent:urlPath] andMethod:method andParams:params andAcceptJSONResponse:acceptJSONResponse andSendBodyAsJSON:sendBodyAsJSON andCompletion:completion];
    }else{
        completion(nil,@"baseURL not set");
    }
    
}

+(void)performRequestWithURLString:(NSString *)url andMethod:(NSString *)method andParams:(NSDictionary *)params andAcceptJSONResponse:(BOOL)acceptJSONResponse andSendBodyAsJSON:(BOOL)sendBodyAsJSON andCompletion:(void (^)(NSData *, NSString *))completion{
    
    NSURL * URL = [NSURL URLWithString:url];
    
    if(method==nil){
        method = @"GET";
    }
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    request.HTTPMethod = method;
    
    if(acceptJSONResponse){
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    
    if(params!=nil){
        if([method isEqualToString:@"POST"]||[method isEqualToString:@"PUT"]||[method isEqualToString:@"DELETE"]||[method isEqualToString:@"PATH"]){
        
            NSData * bodyData = nil;
            if(sendBodyAsJSON){
                NSError * JSONError  = nil;
                bodyData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&JSONError];
                
                if(JSONError!=nil){
                    completion(nil,[@"Error dataWithJSON" stringByAppendingString:[JSONError localizedDescription]]);
                }else{
                    NSString * encodedString = [params encodedStringWithHttpBody];
                    bodyData = [encodedString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
                    if(bodyData==nil){
                        completion(nil,@"couldn't create bodyData");
                        return;
                    }
                    
                    [request setBodyData:bodyData isJSONData:sendBodyAsJSON];
                }
                
                
            }
            
        }
        else{
            NSString * encodedString = [params encodedStringWithHttpBody];
            NSURL * reqURL = [NSURL URLWithString:[[url stringByAppendingString:@"?"]stringByAppendingString:  encodedString]];
            request.URL = reqURL;
        }
        
        NSURLSession * session = [[self sharedInstance] objectForKey:@"urlSession"];
        
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
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
    
}

@end
