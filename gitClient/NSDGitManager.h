//
//  NSDGitManager.h
//  gitClient
//
//  Created by NullStackDev on 24.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDGitManager : NSObject



-(void)processJSONDataWithData:(NSData * )inputData andCompletion:(void (^)(NSDictionary * result)) completion;
-(void)processOAuthWithCallbackURL:(NSURL *)callback;
-(void)setAccessWithToken:(NSString *)token;
+(instancetype)sharedInstance;
@end
