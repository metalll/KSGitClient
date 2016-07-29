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
#import "NSDImageAssetDownloader.h"
@interface NSDBaseViewController ()
{
   
}
@end

@implementation NSDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!NSDGitManager.hasToken){  // тыкс велосипед т.к viewWillAppear вызываеться после ViewDidload!!!
        NSLog(@"No token no auth");
    }
  
    _tableView.delegate = self;
    _tableView.dataSource = self;
  

    
    
    [self initUser];
   
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
        return 90;
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
        return _repos.count; // number of repos;
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
            
           

               [NSDChacheController objectForKey:_user.userAvatarURL andCompletion:^(id object) {
                   
                [[(NSDUserCell *)cell avatarImageView]setImage:(UIImage *)object];
                [[(NSDUserCell *)cell activityIndicator] stopAnimating];
                
                
            }];
            
        }
        
    }
    
    if(indexPath.section == 1){
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
        if([[_repos objectAtIndex:indexPath.row] repoLang] != [NSNull new]){
            [[(NSDRepoCell *)cell lang] setText:[[_repos objectAtIndex:indexPath.row] repoLang]];}
        else{ [[(NSDRepoCell *)cell lang] setText:@"no lang"]; }
        }
        
    
    
    
    
    
    
    
    return cell;
    
}



-(void)initUser{
    [NSDGitManager getCurrentUserWithCompletion:^(NSDictionary *responceDic, NSString *errorString) {
        
        _user = [[NSDUser alloc] initWithDictionary:responceDic];
        
        [NSDGitManager performRequestWithURLString:_user.reposURL andMethod:nil andParams:nil andAcceptJSONResponse:YES andSendBodyAsJSON:NO andCompletion:^(NSData *data, NSString *errorString) {

            NSError * JSONError = nil;
            NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError]);
            _repos = [NSDRepo initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError]];
         [_tableView reloadData];
        }];
        
        
        NSLog(@"username %@",_user.userName);
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
       if(!NSDGitManager.hasToken){
        UIViewController * auth = [self.storyboard instantiateViewControllerWithIdentifier:@"Auth"];
        [self.navigationController presentViewController:auth animated:NO completion:nil];
    }
   
    [_tableView reloadData];
    [super viewWillAppear:animated];

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
