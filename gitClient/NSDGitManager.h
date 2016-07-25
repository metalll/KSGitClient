//
//  NSDGitManager.h
//  gitClient
//
//  Created by NullStackDev on 24.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDNetworkController.h"
@interface NSDGitManager : NSDNetworkController




+(NSDictionary *)sharedInstance;

+(void)searchForReposCountainingWithQueryString:(NSString *)queryString
                                  andCompletion:(void(^)(NSDictionary * responceDic,NSString * errorString))completion;

+(void)searchForUserCountainingWithQueryString:(NSString *)queryString
                                 andCompletion:(void(^)(NSDictionary * responceDic,NSString * errorString))completion;

+(void)getCurrentUserWithCompletion:(void(^)(NSDictionary * responceDic,NSString * errorString))completion;

+(void)newRepoWithName:(NSString *)name
        andDescription:(NSString *)decription
     andInitWithReadMe:(BOOL)initReadMe
     andAllowDownloads:(BOOL)allowDownloads
         andCompletion:(void(^)(NSDictionary * responceDic,NSString * errorString))completion;

+(void)updateUserBioWithNewBio:(NSString *)newBio
                 andCompletion:(void(^)(NSDictionary * responceDic,NSString * errorString))completion;



+(void)setAccesToken:(NSString *)token;

+(void)processOAuth2WithCallbackURI:(NSURL *)callbackURI;

@end
