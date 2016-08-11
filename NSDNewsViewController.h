//
//  NSDNewsViewController.h
//  gitClient
//
//  Created by NullStackDev on 06.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDBaseTableViewController.h"

#import "NSDXMLParser.h"
@interface NSDNewsViewController : NSDBaseTableViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSString * rssLink;
@property (weak) NSDXMLParser * xmlParser;
@property BOOL privateSelfUserFeed;
@end
