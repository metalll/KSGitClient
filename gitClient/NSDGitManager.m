//
//  NSDGitManager.m
//  gitClient
//
//  Created by NullStackDev on 24.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDGitManager.h"
#import "NSURL+NSDNetworkConnection.h"
#import <UIKit/UIKit.h>
#import "NSDGitManager_Private.h"
#import "NSDGitConstants.h"
@implementation NSDGitManager


+ (instancetype)controller {
    @synchronized(self) {
        
    
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
        if([instance token]==nil){
            if([[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]){
                [self setAccesToken:([[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"])];
            }
        }
           if([instance token]==nil){
               [instance setUrlSession: [NSURLSession sharedSession]];}
    });
        return instance;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.baseURL = kGithubAPIURL;
        self.token = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
        if(self.token!=nil){
            [self setToken:(self.token)];
        }
        
        
    }
    return self;
}

+(BOOL)hasToken{
    if([[self controller]token]!=nil) [self setAccesToken:[[self controller] token]];
    return [[self controller] token]!=nil;
}

+(NSString *)URLStringWithPathComponent:(NSString *)pathComponent{
    return [kGithubAPIURL stringByAppendingString:pathComponent];
}

+(void)searchForPath:(NSString *)path andQueryString:(NSString *)query andCompletion:(void (^)(NSDictionary *, NSString *)) completion{
    NSMutableDictionary * params = [NSMutableDictionary new];
    [params setObject:query forKey:@"q"];
    
    [self performRequestWithURLPath:path andMethod:@"GET" andParams:params andAcceptJSONResponse:true andSendBodyAsJSON:NO andCompletion:^(NSData *data, NSString *errorString) {
        [self processJSONData:data andErrorString:errorString andCompletion:completion];
    }];
    
}

+(void)processJSONData:(NSData *)JSONData andErrorString:(NSString *)errorString andCompletion:(void (^)(NSDictionary *, NSString *))completion{
    NSString * newErrorString = errorString;
    if(JSONData!=nil){
        NSError * error = nil;
        NSDictionary * retValDic = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:&error];
        if(errorString!=nil){
            NSLog(@"GitHub error!!!");
            completion(nil,newErrorString);
            return;
        }
        
        if(error!=nil){ completion(nil,@"Error parsing JSON"); return;}
        
        
        
        completion(retValDic,nil);
        return;
    }else {
        completion(nil,@"no data no life ;-(");
        return;
    }
}

+(void)searchForReposCountainingWithQueryString:(NSString *)queryString andCompletion:(void (^)(NSDictionary *, NSString *))    completion{
    [self searchForPath:@"/search/repositories" andQueryString:queryString andCompletion:completion];
}

+(void)searchForUserCountainingWithQueryString:(NSString *)queryString andCompletion:(void (^)(NSDictionary *, NSString *))completion{
    [self searchForPath:@"/search/users" andQueryString:queryString andCompletion:completion];
}

+(void)getCurrentUserWithCompletion:(void (^)(NSDictionary *, NSString *))completion{
    [self performRequestWithURLPath:@"/user" andMethod:@"GET" andParams:nil andAcceptJSONResponse:YES andSendBodyAsJSON:NO andCompletion:^(NSData *data, NSString *errorString) {
        [self processJSONData:data andErrorString:errorString andCompletion:completion];
    }];
}

+(void)newRepoWithName:(NSString *)name andDescription:(NSString *)decription andInitWithReadMe:(BOOL)initReadMe andAllowDownloads:(BOOL)allowDownloads andCompletion:(void (^)(NSDictionary *, NSString *))completion{
    NSMutableDictionary * params = [NSMutableDictionary new];
    [params setObject:name forKey:@"name"];
    if(decription!=nil){
        [params setObject:decription forKey:@"description"];
    }
    if(initReadMe)
    [params setObject:@"true" forKey:@"auto_init"];
    else [params setObject:@"false" forKey:@"auto_init"];
    
    if(allowDownloads)
        [params setObject:@"true" forKey:@"has_downloads"];
    else [params setObject:@"false" forKey:@"has_downloads"];

    [self performRequestWithURLPath:@"/user/repos" andMethod:@"POST" andParams:params andAcceptJSONResponse:true andSendBodyAsJSON:true andCompletion:^(NSData *data, NSString *errorString) {
      [self processJSONData:data andErrorString:errorString andCompletion:^(NSDictionary *responceDic, NSString *errorString) {
          if(errorString!=nil){
              completion(nil,errorString);
              return ;
          }
          
          completion(responceDic,nil);
      }];
    }];
}

+(void)updateUserBioWithNewBio:(NSString *)newBio andCompletion:(void (^)(NSDictionary *, NSString *))completion{
    NSMutableDictionary * userBio = [NSMutableDictionary new];
    [userBio setObject:newBio forKey:@"bio"];
    
    [self performRequestWithURLPath:@"/user" andMethod:@"PATCH" andParams:userBio andAcceptJSONResponse:YES andSendBodyAsJSON:true andCompletion:^(NSData *data, NSString *errorString) {
        [self processJSONData:data andErrorString:errorString andCompletion:completion];
    }];
}

+(NSURLSession *)postAuthSession{
    if([self hasToken]) return [[self controller] urlSession];
    return nil;
}

+(void)setAccesToken:(NSString *)token{
    NSLog(@"setToken %@",token);
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSMutableDictionary * configToken = [NSMutableDictionary new];
    [configToken setObject:[@"token " stringByAppendingString:token] forKey:@"Authorization"];
    [config setHTTPAdditionalHeaders:configToken];
   [(NSDNetworkController *)[self controller] setUrlSession:[NSURLSession sessionWithConfiguration:config]];
   }


+(NSString *)requestOAuth2Access{
    NSString * retVal = [[[[kGithubOAuthURLString stringByAppendingString:@"?client_id="] stringByAppendingString:kGithubID] stringByAppendingString:@"&scope="] stringByAppendingString:kGithubScope];
    
    return retVal;
}

+(void)processOAuth2WithCallbackURI:(NSURL *)callbackURI andCompletion:(void(^)()) completionToken{
    
    NSDictionary * callbackParams = [callbackURI dictionaryFromURL];
    NSString * code = [callbackParams objectForKey:@"code"];
    NSMutableDictionary * requestParams = [NSMutableDictionary new];
    [requestParams setObject:kGithubID forKey:@"client_id"];
    [requestParams setObject:kGithubSecret forKey:@"client_secret"];
    [requestParams setObject:code forKey:@"code"];
    
    [self performRequestWithURLString:kGithubAccessTokenURLString andMethod:@"POST" andParams:requestParams andAcceptJSONResponse:YES andSendBodyAsJSON:YES andCompletion:^(NSData *data, NSString *errorString) {
        NSError * JSONError = nil;
        if(errorString!=nil){
            NSLog(@"err");
            return;
        }
        NSMutableDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError];
        
        NSString * tttoken = [responceDic objectForKey:@"access_token"];
        [[NSUserDefaults standardUserDefaults] setObject:tttoken forKey:@"accessToken"];
   [(NSDGitManager *)[self controller] setToken:tttoken];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
             [self setAccesToken:tttoken];
            
             completionToken();
         });
        
       
        return;
        
    }];
}


@end
