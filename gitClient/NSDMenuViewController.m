//
//  NSDMenuViewController.m
//  gitClient
//
//  Created by NullStackDev on 25.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDMenuViewController.h"
#import "NSDMenuItemCell.h"
#import "NSDNavigatorController.h"
#import "NSDDetaliedUserProfileViewController.h"
#import "NSDNewsViewController.h"
#import "NSDOAuthViewController.h"
#import "NSDActivityViewController.h"
#import "NSDReposViewController.h"
@interface NSDMenuViewController ()
{
    BOOL firstLoad;
}
@end

@implementation NSDMenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _currentViewController = 3;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning
     ];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_currentViewController inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"menuCell";
    
    NSDMenuItemCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell){
        cell = [[NSBundle mainBundle] loadNibNamed:@"NSDMenuItemCell" owner:self options:nil].lastObject;
        
    }
    
    switch (indexPath.row) {
        case 0:
            cell.menuLabel.text = @"Your Profile";
            cell.menuLogo.image = [UIImage imageNamed:@"profile"];
            break;
        case 1:
            cell.menuLabel.text = @"Repositories";
            cell.menuLogo.image = [UIImage imageNamed:@"repo"];
            break;
        case 2:
            cell.menuLabel.text = @"Activity";
            cell.menuLogo.image = [UIImage imageNamed:@"activity"];
            break;
        case 3:
            cell.menuLabel.text = @"News";
             cell.menuLogo.image = [UIImage imageNamed:@"news"];
          //  NSLog(@"index path row %ld",(long)indexPath.row);
           // NSLog(@"index path section %ld",(long)indexPath.section);
            break;
//       case 4:
//            cell.menuLabel.text = @"About";
//            cell.menuLogo.image = [UIImage imageNamed:@"oIssue"];
//            break;
        default:
            cell.menuLabel.text = @"Sign Out";
            cell.menuLogo.image = [UIImage imageNamed:@"signOut"];
        break;
    }
    
    return cell;
    
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(firstLoad){
        firstLoad = YES;
        return;
    }
    _currentViewController = indexPath.row;
    UIStoryboard * __weak storyboard = [[NSDNavigatorController sharedInstance] storyboard];
    NSDBaseViewController * vc ;
    
    if(indexPath.row == 0){
        vc = [storyboard instantiateViewControllerWithIdentifier:@"detaliedUserProfile"];
        NSDDetaliedUserProfileViewController * __weak dvc = (NSDDetaliedUserProfileViewController *)vc;
        dvc.user = [[NSDNavigatorController sharedInstance]  currentUser];
        
    }
    
    if(indexPath.row == 1){
        vc = [storyboard instantiateViewControllerWithIdentifier:@"repos"];
        NSDReposViewController * __weak rVC = (NSDReposViewController *)vc;
        rVC.reposURL = [[NSDNavigatorController sharedInstance] currentUser].reposURL;
        
    }

    
    if(indexPath.row == 2){
        vc = [storyboard instantiateViewControllerWithIdentifier:@"Acitivity"];
        NSDActivityViewController * __weak nVC = (NSDActivityViewController *)vc;
        [nVC reloadInputViews];
        nVC.userActivity = YES;
        nVC.privateSelfUserFeed = YES;
        nVC.loaded = NO;
       
    }

    
    if(indexPath.row == 3){
        vc = [storyboard instantiateViewControllerWithIdentifier:@"News"];
        
        NSDNewsViewController * __weak nVC = (NSDNewsViewController *)vc;
        [nVC reloadInputViews];
        nVC.privateSelfUserFeed = YES;
        nVC.loaded = NO;
        
    }

  
    
    
    if(indexPath.row == 4){
        UIViewController * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"Auth"];
        
        
        NSDOAuthViewController * __weak oauth = (NSDOAuthViewController *)vc1;
        [oauth reloadInputViews];
        oauth.loadURL = @"https://github.com/logout";
        [[[NSDNavigatorController sharedInstance]gitApi] signOut];
        
        
        [[NSDNavigatorController sharedInstance] presentViewController:vc1 animated:NO completion:^{
            
        }];
        
        vc = [storyboard instantiateViewControllerWithIdentifier:@"News"];
        
        NSDNewsViewController * __weak nVC = (NSDNewsViewController *)vc;
        [nVC reloadInputViews];
        nVC.privateSelfUserFeed = YES;
        nVC.loaded = NO;
        

        
        _currentViewController = 3;
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_currentViewController inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];

        
        //return;
    
    }
    
    
    [[NSDNavigatorController sharedInstance]  popAllAndSwitchToViewController:vc withSlideOutAnimation:YES andCompletion:^{
       [vc startView];
    }];
    
    
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
