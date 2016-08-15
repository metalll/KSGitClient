//
//  NSDBaseViewController.m
//  gitClient
//
//  Created by NullStackDev on 25.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDDetaliedUserProfileViewController.h"
#import "NSDGitManager.h"
#import "NSDUserCell.h"
#import "NSDRepoCell.h"
#import "NSDUser.h"
#import "NSDUser+NSDInitUserWithDictionary.h"
#import "NSDCacheController.h"
#import "NSDRepo+InitWithDictionary.m"
#import "NSDNavigatorController.h"
#import "NSDSimpleCell.h"
#import "NSDReposViewController.h"
#import "NSDUserViewController.h"
@interface NSDDetaliedUserProfileViewController ()
{
   
    NSInteger userCellHeight;
}
@end

@implementation NSDDetaliedUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.alpha = 0;
    _activityIndicator.hidesWhenStopped = YES;
    [_activityIndicator startAnimating];
    [self startView];

    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0) return @"";
    else return [_user.userLogin stringByAppendingString:@" repositories"];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0&& indexPath.row == 0){
        return 152+userCellHeight;
    }
    else{
        
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0) return 0;
    
    return 33;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 5;
    }
//    else {
//        if(loadedRepo) return _repos.count; // number of repos;
//        return 1;
//    }
    return 1;
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
            
            
            if((id)_user.userLogin != [NSNull null])
                [[(NSDUserCell *)cell userLogin]setText:_user.userLogin];else{[[(NSDUserCell *)cell userLogin]setText:@""];}
            
            if((id)_user.userName != [NSNull null])
            [[(NSDUserCell *)cell userName]setText:_user.userName];
            else{[[(NSDUserCell *)cell userName]setText:@""];}
            
            if((id)_user.userEmail != [NSNull null]){
                [[(NSDUserCell *)cell mail]setText:_user.userEmail];
            [[(NSDUserCell *)cell mailLogo] setAlpha:1];}
            else{[[(NSDUserCell *)cell mail]setText:@""];
                
                [[(NSDUserCell *)cell mailLogo] setAlpha:0];
            }
            
            
            if((id)_user.userBio != [NSNull null]){
            float viewWidth = (self.view.frame.size.width-16)/10.1; //внимание велосипед!! берем прикидываем ширину лейбла с биографией и делим ее на примерную ширину символа
            float viewRowsCount = _user.userBio.length / viewWidth; //далее берем посчитываем кол-во столбцов
            NSLog(@"%@",_user.userBio);
            NSLog(@"%f",viewRowsCount);
                
                
                
            [(UILabel *)[(NSDUserCell *)cell bio]setNumberOfLines:ceilf(viewRowsCount)]; // далее округляем и закидываем в количество столбцов bio лейбла
          userCellHeight = 18 * ceilf(viewRowsCount); // далее примерная высота лейбла после манипуляций
                // и плюсуем эти расчеты к стоковой высоте cell'a (чуть выше) профит!!
                
                [(UILabel *)[(NSDUserCell *)cell bio]setText:_user.userBio];
            }
            else{ [(UILabel *)[(NSDUserCell *)cell bio]setText:@""]; }
            
          
            [[(NSDUserCell *)cell followersCount] setText:[ NSString stringWithFormat:@"%@", _user.followersCount]];
            
            NSDate * date = [self parseRFC3339Date:_user.joinedOn];
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            NSString *articleDateString = [dateFormatter stringFromDate:date];
            
            
            [[(NSDUserCell *)cell joined]setText:articleDateString];
            [[(NSDUserCell *)cell followingCount] setText:[ NSString stringWithFormat:@"%@", _user.followingCount]];
            
            [[[NSDNavigatorController sharedInstance] gitApi] getCurrentUserStarredWithCompletion:^(NSDictionary *responceDic, NSString *errorString) {
                
                [(UILabel *)[(NSDUserCell *)cell starredCount]setText:[NSString stringWithFormat:@"%d",responceDic.count]];
                
            }];
            
            [self.cache objectForKey:_user.userAvatarURL andCompletion:^(id object) {
                [[(NSDUserCell *)cell avatarImageView]setImage:(UIImage *)object];
                [[(NSDUserCell *)cell activityIndicator] stopAnimating];
              
                
            }];
            
        }
        
    }
    
    if(indexPath.row >= 1){
        cellID = @"simpleCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if(!cell){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NSDSimpleCell"owner:self options:nil];
            cell = [nib lastObject];}
            NSDSimpleCell * __weak sCell = (NSDSimpleCell *) cell;
            switch (indexPath.row) {
                case 1:
                   sCell.simpleName.text = [_user.userLogin stringByAppendingString: @"'s followers"];
                   sCell.SimpleCount.text = [ NSString stringWithFormat:@"%@", _user.followersCount];
                    break;
                case 2:
                    sCell.simpleName.text = [_user.userLogin stringByAppendingString: @"'s starred"];

                    break;
                case 3:
                    sCell.simpleName.text = [_user.userLogin stringByAppendingString: @"'s following"];
                    sCell.SimpleCount.text = [ NSString stringWithFormat:@"%@", _user.followingCount];
                    break;
                case 4:
                    sCell.simpleName.text = [_user.userLogin stringByAppendingString: @"'s repos"];
                    sCell.SimpleCount.text = [ NSString stringWithFormat:@"%@",_user.userPublicRepoCount];
                    break;
                default:
                      sCell.simpleName.text = @"Edit Profile";
                    sCell.SimpleCount.alpha = 0;
                    break;
            }
            
            if(indexPath.row == 2){
                if(!_user) return cell;
                
                
                
                [self.gitApi performRequestWithURLString: [self reformatURlWithString:_user.starredURL] andMethod:@"GET" andParams:nil andAcceptJSONResponse:YES andSendBodyAsJSON:NO andCompletion:^(NSData *data, NSString *errorString) {
                    NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    
                    
                     sCell.SimpleCount.text =[NSString stringWithFormat:@"%d",responceDic.count];
                }];
                
                
                

//            [[[NSDNavigatorController sharedInstance] gitApi] perf:^(NSDictionary *responceDic, NSString *errorString) {
//
//                }];
            }
            
        
        
        
        
    }
    
    
    
    
    
    
    return cell;
    
}





-(void)startView{
   
  
    
    
//    [[self gitApi] getCurrentUserWithCompletion:^(NSDictionary *responceDic, NSString *errorString) {
//       
//        self.user = [[NSDUser alloc] initWithDictionary:responceDic];
        _tableView.alpha=1;
        self.title =[[_user userLogin]stringByAppendingString:@"'s profile"];
        [_activityIndicator stopAnimating];
        [_tableView reloadData];

//    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *) reformatURlWithString:(NSString *)string{
    NSString * retVal;
    NSUInteger location = [string rangeOfString:@"{"].location;
    retVal = [string substringToIndex:location];
    
    
    
    return retVal;
}

- (NSDate *)parseRFC3339Date:(NSString *)dateString
{
    NSDateFormatter *rfc3339TimestampFormatterWithTimeZone = [[NSDateFormatter alloc] init];
    [rfc3339TimestampFormatterWithTimeZone setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] ];
    [rfc3339TimestampFormatterWithTimeZone setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    NSDate *theDate = nil;
    NSError *error = nil;
    if (![rfc3339TimestampFormatterWithTimeZone getObjectValue:&theDate forString:dateString range:nil error:&error]) {
        NSLog(@"Date '%@' could not be parsed: %@", dateString, error);
    }
    
    return theDate;
}


- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    if(indexPath.row == 4){
            NSDReposViewController * vc;
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"repos"];
            NSDReposViewController * __weak rVC = (NSDReposViewController *)vc;
            rVC.reposURL = _user.reposURL;
       
               rVC.hideLeftMenu = YES;
        [[NSDNavigatorController sharedInstance] pushViewController:vc animated:YES];
        
    }
    if(indexPath.row == 1){
        NSDUserViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"users"];
        vc.hideLeftMenu = YES;
        vc.Utitle = [[(NSDSimpleCell *)[tableView cellForRowAtIndexPath:indexPath]simpleName] text];
        vc.loadurl = _user.followersURL;
         [[NSDNavigatorController sharedInstance] pushViewController:vc animated:YES];
    
    }
    if(indexPath.row == 2){
        NSDReposViewController * vc;
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"repos"];
        NSDReposViewController * __weak rVC = (NSDReposViewController *)vc;
        rVC.reposURL = [self reformatURlWithString:_user.starredURL];
        rVC.title = [[(NSDSimpleCell *)[tableView cellForRowAtIndexPath:indexPath]simpleName] text];
        rVC.hideLeftMenu = YES;
        [[NSDNavigatorController sharedInstance] pushViewController:vc animated:YES];
        
    }
    
    if(indexPath.row ==3){
        NSDUserViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"users"];
        vc.hideLeftMenu = YES;
        vc.Utitle = [[(NSDSimpleCell *)[tableView cellForRowAtIndexPath:indexPath]simpleName] text];
        vc.loadurl =[self reformatURlWithString:_user.followingURL];
        [[NSDNavigatorController sharedInstance] pushViewController:vc animated:YES];

    }
    
//   // if(indexPath.row ==4){
//        NSDUserViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"users"];
//        vc.hideLeftMenu = YES;
//        vc.Utitle = [[(NSDSimpleCell *)[tableView cellForRowAtIndexPath:indexPath]simpleName] text];
//        vc.loadurl =[self reformatURlWithString:_user.followingURL];
//        [[NSDNavigatorController sharedInstance] pushViewController:vc animated:YES];
//        
//    }
    
    }

-(BOOL)slideNavigationControllerShouldDisplayLeftMenu{
    return !self.hideLeftMenu;
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
