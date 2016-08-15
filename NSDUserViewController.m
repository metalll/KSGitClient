//
//  NSDUserViewController.m
//  gitClient
//
//  Created by NullStackDev on 15.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDUserViewController.h"
#import "NSDUser.h"
#import "NSDUser+NSDInitUserWithDictionary.h"
#import "NSDUserCell.h"
#import "NSDDetaliedUserProfileViewController.h"

@interface NSDUserViewController ()
{
    NSUInteger pageNumber;
    NSMutableArray <NSDUser * > * allUsers;
    BOOL end;
}
@end

@implementation NSDUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    pageNumber = 2;
    self->allUsers = [NSMutableArray new];
    [self startView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"Ucell";
    NSDUserCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell){
        cell = (NSDUserCell *)[[[NSBundle mainBundle]loadNibNamed:@"NSDUserCell" owner:self options:0] lastObject];
    }
    
    NSDUser * processUser = [allUsers objectAtIndex:indexPath.row];
    if((id)processUser.userName!=[NSNull null])
    cell.userName.text = processUser.userName;
    else{
    cell.userName.text = @"";
    }
    if((id)processUser.userLogin!=[NSNull null])
        cell.userName.text = processUser.userLogin;
    else{
        cell.userName.text = @"";
    }
    
    
    cell.userLogin.text = @"";
    if((id)processUser.userEmail!=nil){
        cell.mail.text = processUser.userName;
        [cell.mailLogo setAlpha:1];
    }
    else{
        cell.mail.text = @"";
        cell.mailLogo.alpha = 0;
    }
    
    cell.bio.text = @"";
          [cell.joinedLogo setAlpha:0];
        cell.joined.text=@"";
    
         
    [self.cache objectForKey:processUser.userAvatarURL andCompletion:^(id object) {
        
        cell.avatarImageView.image = (UIImage *)object;
        [cell.activityIndicator stopAnimating];
        
        
    }];
    
            if(indexPath.row>=allUsers.count-4&&allUsers.count>20){
            if(!end){
                [self moreDownload];}
        }

    
    
    return cell;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return allUsers.count;
}

-(void)startView{
    self.title = self.Utitle;
    
    [self.gitApi performRequestWithURLString:self.loadurl andMethod:@"GET" andParams:nil andAcceptJSONResponse:YES andSendBodyAsJSON:NO andCompletion:^(NSData *data, NSString *errorString) {
        if(errorString == nil){
        NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"responceDic %@",responceDic );
        for(NSDictionary * acc in (NSArray *)responceDic){
            [self->allUsers addObject:[[NSDUser alloc] initWithDictionary:acc]];
        }
        }
        
        NSLog(@"err %@", errorString);
        [_tableView reloadData];
    }];
    
    
    
}

-(void)moreDownload{
    
    //?page=2&per_page=100
    NSString *appString = [@"?page=" stringByAppendingString:[NSString stringWithFormat:@"%lu",(unsigned long)pageNumber]];
    
    
    
    NSLog(@"%@",[self.loadurl stringByAppendingString:appString]);
    pageNumber++;
    
    [self.gitApi performRequestWithURLString:[self.loadurl stringByAppendingString:appString] andMethod:@"GET" andParams:nil andAcceptJSONResponse:YES andSendBodyAsJSON:NO andCompletion:^(NSData *data, NSString *errorString) {
        if(errorString == nil&&data!=nil){
            NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            // if([responceDic isEqualToDictionary:[NSDictionary new]]) {end = YES;}
            if(responceDic.count<=1){end=YES;}
            for(NSDictionary * acc in (NSArray *)responceDic){
                [self->allUsers addObject:[[NSDUser alloc] initWithDictionary:acc]];
            }
        }
        
        else{
            end = YES;
        }
        
        [_tableView reloadData];
    }];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    
    [self.gitApi performRequestWithURLString:[allUsers objectAtIndex:indexPath.row].userURL andMethod:@"GET" andParams:nil andAcceptJSONResponse:YES andSendBodyAsJSON:NO andCompletion:^(NSData *data, NSString *errorString) {
        if(errorString == nil&& data){
            NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSDDetaliedUserProfileViewController * dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"detaliedUserProfile"];
            dvc.user = [[NSDUser alloc] initWithDictionary:responceDic];
            dvc.hideLeftMenu = YES;
            
            [self.navigationController pushViewController:dvc animated:YES];
            [dvc startView];
            
        }
        else{
            end = YES;
        }
       
    }];

    
    
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
