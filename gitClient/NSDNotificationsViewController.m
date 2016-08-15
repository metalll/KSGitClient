//
//  NSDNotificationsViewController.m
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDNotificationsViewController.h"
#import "NSDNotif.h"


@implementation NSDNotificationsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return notifications.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"notificCell";
    NSDNotif * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell){
    
        cell = [[NSBundle mainBundle] loadNibNamed:@"NSDNotif" owner:self options:nil].lastObject;
    }
    
    NSDNotification * model = [notifications objectAtIndex:indexPath.row];
    
    cell.firstLabel.text = model.firstTitle;
    cell.typeLabel.text = model.typeTitle;
    
    
    return cell;
}


-(void)startView{
    
    [self.gitApi getCurrentUserNotificationsWithGetAllNotif:YES andCompletion:^(NSDictionary *responceDic, NSString *errorString) {
        notifications = [NSMutableArray new];

       dispatch_async(dispatch_get_main_queue(), ^{
           for(int i = 0;i<[(NSArray *)responceDic count];i++){
               [notifications addObject:[[NSDNotification alloc] initWithDictionary:responceDic andIndex:i]];
               
           }
           [_tableView reloadData];
       });
       
    }];
    
}

@end
