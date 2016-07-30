//
//  NSDBaseViewController.m
//  gitClient
//
//  Created by NullStackDev on 25.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDBaseViewController.h"
#import "NSDGitManager.h"
#import "NSDUserCell.h"
#import "NSDRepoCell.h"
#import "NSDUser.h"
#import "NSDUser+NSDInitUserWithDictionary.h"
#import "NSDChacheController.h"
#import "NSDRepo+InitWithDictionary.m"
#import "NSDBaseNavigatorController.h"
@interface NSDBaseViewController ()
{
    BOOL loadedRepo;
}
@end

@implementation NSDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.alpha = 0;
     _activityIndicator.hidesWhenStopped = YES;
     [_activityIndicator startAnimating];


    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0) return @"";
    else return [_user.userLogin stringByAppendingString:@" repositories"];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0&& indexPath.row == 0){
        return 101;
    }
    else{
        if(loadedRepo) return 82;
        return 200;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0) return 0;
    
    return 33;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }
    else {
        if(loadedRepo) return _repos.count; // number of repos;
        return 1;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID;
    UITableViewCell * cell;
    if(indexPath.row == 0&&indexPath.section == 0){
         cellID = @"userCell";
        NSLog(@"%@", _user);
         cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell==nil){
            
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NSDUserCell"owner:self options:nil];
            
            cell = [nib lastObject];
        }
        if(_user!=nil){
            [[(NSDUserCell *)cell activityIndicator]startAnimating];
            [[(NSDUserCell *)cell userName]insertText:_user.userName];
            [[(NSDUserCell *)cell userLogin]insertText:_user.userLogin];
            NSDChacheController * __weak chache = [[NSDBaseNavigatorController sharedInstance] chache];
            [chache objectForKey:_user.userAvatarURL andCompletion:^(id object) {
                   
                [[(NSDUserCell *)cell avatarImageView]setImage:(UIImage *)object];
                [[(NSDUserCell *)cell activityIndicator] stopAnimating];
                
                
            }];
            
        }
        
    }
    
    if(indexPath.section == 1){
        
        if(!loadedRepo){
            return [[[NSBundle mainBundle] loadNibNamed:@"NSDProgressCell"owner:self options:nil] lastObject];
        }
        
        cellID = @"repo";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if(cell == nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NSDRepoCell"owner:self options:nil];
            cell = [nib lastObject];
            [(NSDRepoCell *)cell setIndetifireWithString:cellID];
        }
        
        
        if([[_repos objectAtIndex:indexPath.row] isFork]){
            [[(NSDRepoCell *)cell repoImageView] setImage:[UIImage imageNamed:@"fork"]];
        }else{
            [[(NSDRepoCell *)cell repoImageView] setImage:[UIImage imageNamed:@"repo"]];}
        
        [[(NSDRepoCell *)cell repoName] setText:[NSString stringWithFormat:@"%@",[[_repos objectAtIndex:indexPath.row] repoName]]] ;
        [[(NSDRepoCell *)cell starCount] setText:[NSString stringWithFormat:@"%@",[[_repos objectAtIndex:indexPath.row] stars]]];
        [[(NSDRepoCell *)cell forkCount] setText:[NSString stringWithFormat:@"%@",[[_repos objectAtIndex:indexPath.row] forks]]];
        }
        
    
    
    
    
    
    
    
    return cell;
    
}



-(void)startView{
    [_activityIndicator stopAnimating];
    [_tableView reloadData];
    _tableView.alpha=1;
    
    NSDGitManager * __weak gitApi = [NSDBaseNavigatorController sharedInstance].gitApi;
    
    [gitApi getReposWithStringURL:_user.reposURL andCompletion:^(NSDictionary *responceDic, NSString *errorString) {
       
        NSLog(@"%@",responceDic);
        _repos = [NSDRepo initWithDictionary:responceDic];
        loadedRepo=YES;
        [_tableView reloadData];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
