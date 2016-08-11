//
//  NSDBaseTableViewController.m
//  gitClient
//
//  Created by NullStackDev on 11.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDBaseTableViewController.h"

@implementation NSDBaseTableViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return nil;
}


@end
