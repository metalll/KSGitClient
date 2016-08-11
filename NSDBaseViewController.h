//
//  NSDBaseViewController.h
//  gitClient
//
//  Created by NullStackDev on 11.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDGitManager.h"
#import "NSDCacheController.h"
#import "NSDSlideNavigatorController.h"
@interface NSDBaseViewController : UIViewController<NSDSlideNavigationControllerDelegate>
@property(weak) NSDGitManager * gitApi;
@property(weak) NSDCacheController * cache;

-(void)startView;
-(BOOL)slideNavigationControllerShouldDisplayLeftMenu;
-(BOOL)slideNavigationControllerShouldDisplayRightMenu;

@end
