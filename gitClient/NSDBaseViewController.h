//
//  NSDBaseViewController.h
//  gitClient
//
//  Created by NullStackDev on 25.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDUser.h"
#import "NSDRepo.h"
#import "NSDSlideNavigatorController.h"
@interface NSDBaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSDSlideNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak)NSDUser * user;
@property NSArray * repos;

-(void)startView;

@end
