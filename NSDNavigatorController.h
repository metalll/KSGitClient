//
//  NSDBaseNavigatorController.h
//  gitClient
//
//  Created by NullStackDev on 30.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDSlideNavigatorController.h"
#import "NSDGitManager.h"
#import "NSDCacheController.h"
#import "NSDUser.h"
@interface NSDNavigatorController : NSDSlideNavigationController
@property NSDUser * currentUser;
@property(weak) NSDGitManager * gitApi;
@property(weak) NSDCacheController * cache;

-(void)initUser;



@end
