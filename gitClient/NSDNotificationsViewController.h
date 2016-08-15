//
//  NSDNotificationsViewController.h
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDGitManager.h"
#import "NSDCacheController.h"
#import "NSDNotification.h"

@interface NSDNotificationsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray <NSDNotification *> * notifications;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,weak) NSDGitManager * gitApi;

-(void)startView;

@end
