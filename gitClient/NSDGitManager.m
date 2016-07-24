//
//  NSDGitManager.m
//  gitClient
//
//  Created by NullStackDev on 24.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDGitManager.h"

#import <UIKit/UIKit.h>

@implementation NSDGitManager
-(void)requestOAuth2Access{
    NSLog(@"AUTH step 1 getCode");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/login/oauth/authorize?client_id=90148ae988fcef1f0bb3&scope=user,repo" ]];
    
}

-(void)processOAuthWithCallbackURL:(NSURL *)callback{

    
    
}

-(void)setAccessWithToken:(NSString *)token{

}

-(void)processJSONDataWithData:(NSData *)inputData andCompletion:(void (^)(NSDictionary *))completion{

    
}



@end
