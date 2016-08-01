//
//  NSDNotificationsViewController.m
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDNotificationsViewController.h"

@implementation NSDNotificationsViewController

-(void)viewDidLoad{
    [super viewDidLoad];

    

}

-(void)startView{
    
    [self.gitApi getCurrentUserNotificationsWithGetAllNotif:YES andCompletion:^(NSDictionary *responceDic, NSString *errorString) {
        
    }];
    
}

@end
