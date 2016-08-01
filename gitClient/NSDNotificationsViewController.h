//
//  NSDNotificationsViewController.h
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDGitManager.h"
@interface NSDNotificationsViewController : UIViewController
@property(nonatomic,weak) NSDGitManager * gitApi;

-(void)startView;

@end
