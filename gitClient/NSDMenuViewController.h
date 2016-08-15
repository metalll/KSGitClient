//
//  NSDMenuViewController.h
//  gitClient
//
//  Created by NullStackDev on 25.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NSDSlideNavigatorController.h"
@interface NSDMenuViewController :UIViewController <NSDSlideNavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSUInteger currentViewController;


@end
