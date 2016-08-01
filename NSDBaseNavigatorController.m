//
//  NSDBaseNavigatorController.m
//  gitClient
//
//  Created by NullStackDev on 30.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDBaseNavigatorController.h"
#import "NSDUser+NSDInitUserWithDictionary.h"
#import "NSDOAuthViewController.h"
#import "NSDBaseViewController.h"
#import "NSDNotificationsViewController.h"
@implementation NSDBaseNavigatorController


-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)setup{
     [super setup];
    _gitApi = [[NSDGitManager alloc]init];
    _currentUser = nil;
    _chache = [NSDChacheController new];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(!_gitApi.hasToken){
        NSDOAuthViewController *auth = (NSDOAuthViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"Auth"];
        auth.loadURL = _gitApi.requestOAuth2Access;
        [self presentViewController:auth animated:YES completion:nil];
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
            
            
            
            
        }
        NSDNotificationsViewController * __weak notific = (NSDNotificationsViewController *)self.rightMenu;
        notific.gitApi = [self gitApi];
        [notific startView];
        
        NSDBaseViewController * __weak base = (NSDBaseViewController *)self.topViewController;
        base.user = _currentUser;
        [base startView];
    }];
}

@end
