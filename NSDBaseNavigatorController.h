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
#import "NSDChacheController.h"
#import "NSDUser.h"
@interface NSDBaseNavigatorController : NSDSlideNavigationController
@property NSDUser * currentUser;
@property NSDGitManager * gitApi;
@property NSDChacheController * chache;

-(void)initUser;



@end
