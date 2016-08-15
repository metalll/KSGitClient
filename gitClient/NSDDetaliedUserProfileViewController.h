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
#import "NSDBaseTableViewController.h"
@interface NSDDetaliedUserProfileViewController : NSDBaseTableViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSDUser * user;
@property NSArray * repos;
@property BOOL hideLeftMenu;


@end
