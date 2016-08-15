//
//  NSDActivityViewController.h
//  gitClient
//
//  Created by NullStackDev on 13.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDNewsViewController.h"

@interface NSDActivityViewController : NSDBaseTableViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSString * rssLink;
@property (weak) NSDXMLParser * xmlParser;
@property BOOL privateSelfUserFeed;
@property BOOL userActivity;
@property BOOL loaded;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
