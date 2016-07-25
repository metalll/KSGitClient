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

@implementation NSDGitManager
+(instancetype)sharedInstance{
    static NSDGitManager * _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[NSDGitManager alloc] init];
    });
    return _sharedInstance;
    
}



-(void)processOAuthWithCallbackURL:(NSURL *)callback{
    NSString * reqCode = [[callback dictionaryFromURL] objectForKey:@"code"];
    NSLog(@"AUTH step 2 code requsted code : %@",reqCode);
    
    
}

-(void)setAccessWithToken:(NSString *)token{

    
    
}

-(void)processJSONDataWithData:(NSData *)inputData andCompletion:(void (^)(NSDictionary *))completion{

    
}



@end
