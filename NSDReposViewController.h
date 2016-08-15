//
//  NSDReposViewController.h
//  gitClient
//
//  Created by NullStackDev on 15.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDBaseTableViewController.h"

@interface NSDReposViewController : NSDBaseTableViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) NSString * reposURL;
@property BOOL hideLeftMenu;

@end
