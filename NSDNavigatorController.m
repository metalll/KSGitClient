//
//  NSDBaseNavigatorController.m
//  gitClient
//
//  Created by NullStackDev on 30.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDNavigatorController.h"
#import "NSDUser+NSDInitUserWithDictionary.h"
#import "NSDOAuthViewController.h"
#import "NSDDetaliedUserProfileViewController.h"
#import "NSDNotificationsViewController.h"
#import "NSDNewsViewController.h"
@implementation NSDNavigatorController


-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)setup{
     [super setup];
    _gitApi = [NSDGitManager sharedInstance];
    _cache = [NSDCacheController sharedInstance];
    _currentUser = nil;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationBar.barTintColor = [UIColor whiteColor];
    
    if(!_gitApi.hasToken){
        NSDOAuthViewController *auth = (NSDOAuthViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"Auth"];
        auth.loadURL = _gitApi.requestOAuth2Access;
        [self presentViewController:auth animated:YES completion:nil];
    
        return;
    }
    else {
        [self initUser];
        
    }

}






-(void)initUser{
        [_gitApi getCurrentUserWithCompletion:^(NSDictionary *responceDic, NSString *errorString) {
        _currentUser = [[NSDUser alloc] initWithDictionary:responceDic];
        if(errorString!=nil){
            _gitApi.token = nil;
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"accessToken"];
            NSDOAuthViewController *auth = (NSDOAuthViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"Auth"];
            auth.loadURL = _gitApi.requestOAuth2Access;
            [self presentViewController:auth animated:YES completion:nil];
            return ;
        }
            
        NSDNotificationsViewController * __weak notific = (NSDNotificationsViewController *)self.rightMenu;
        notific.gitApi = [self gitApi];
        [notific startView];
        
                  
            
        NSDNewsViewController * __weak news = (NSDNewsViewController *)self.topViewController;
            if([self.topViewController isKindOfClass:[NSDNewsViewController class]]){
                news.privateSelfUserFeed = YES;}
        [news startView];
    }];
}

@end
