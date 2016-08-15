//
//  NSDUserViewController.h
//  gitClient
//
//  Created by NullStackDev on 15.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDBaseTableViewController.h"

@interface NSDUserViewController : NSDBaseTableViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property BOOL hideLeftMenu ;
@property NSString * Utitle;
@property NSString * loadurl;
@end
