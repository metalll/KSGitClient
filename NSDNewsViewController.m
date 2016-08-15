//
//  NSDNewsViewController.m
//  gitClient
//
//  Created by NullStackDev on 06.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDNewsViewController.h"
#import "NSDNewsRssEntry.h"
#import "NSDFeedCell.h"
#import "NSDNavigatorController.h"
#import "NSDMenuViewController.h"
@interface NSDNewsViewController(){
    NSMutableArray<NSDNewsRssEntry *> * allRssEntry;
    
}
@end

@implementation NSDNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _xmlParser = [NSDXMLParser sharedInstance];
    self->allRssEntry = [NSMutableArray new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.alpha = 0;

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return self->allRssEntry.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 57;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    static NSString * cellID = @"feedCell";
    NSDFeedCell * cell = (NSDFeedCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
            cell = (NSDFeedCell *)[[[NSBundle mainBundle] loadNibNamed:@"NSDFeedCell"owner:self options:nil] lastObject];
    }
    
    [self.cache objectForKey:[allRssEntry objectAtIndex:indexPath.row].authorAvatarUrl andCompletion:^(id object) {
        cell.logo.image = (UIImage *)object;
        [cell.feedActivityIndicartor stopAnimating];
    }];
    
    cell.feedContentLabel.text = [allRssEntry objectAtIndex:indexPath.row].content;
    
    
    NSDate * date = [self parseRFC3339Date:[allRssEntry objectAtIndex:indexPath.row].published];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
     NSString *articleDateString = [dateFormatter stringFromDate:date];
    
    cell.feedDataLabel.text = articleDateString;
    //NSLog(@"%@",[allRssEntry objectAtIndex:indexPath.row].type);
    if([[allRssEntry objectAtIndex:indexPath.row].type isEqualToString:@"createdRepo"]){
        cell.typeLogo.image = [UIImage imageNamed:@"repo"];
        
    }
    if([[allRssEntry objectAtIndex:indexPath.row].type isEqualToString:@"star"]){
        cell.typeLogo.image = [UIImage imageNamed:@"star"];
        
    }
    if([[allRssEntry objectAtIndex:indexPath.row].type isEqualToString:@"fork"]||[[allRssEntry objectAtIndex:indexPath.row].type isEqualToString:@"createdBranch"]){
        cell.typeLogo.image = [UIImage imageNamed:@"fork"];
        
    }
    
    if([[allRssEntry objectAtIndex:indexPath.row].type isEqualToString:@"comment"]){
        cell.typeLogo.image = [UIImage imageNamed:@"comment"];
        
    }
    
    if([[allRssEntry objectAtIndex:indexPath.row].type isEqualToString:@"push"]){
        cell.typeLogo.image = [UIImage imageNamed:@"push"];
        
    }
    
    if([[allRssEntry objectAtIndex:indexPath.row].type isEqualToString:@"merge"]){
        cell.typeLogo.image = [UIImage imageNamed:@"merge"];
        
    }
    if([[allRssEntry objectAtIndex:indexPath.row].type isEqualToString:@"oIssue"]){
        cell.typeLogo.image = [UIImage imageNamed:@"oIssue"];
        
    }
    if([[allRssEntry objectAtIndex:indexPath.row].type isEqualToString:@"cIssue"]){
        cell.typeLogo.image = [UIImage imageNamed:@"cIssue"];
        
    }
    
    if([allRssEntry objectAtIndex:indexPath.row].type == nil){
       cell.typeLogo.image = [UIImage imageNamed:@"push"];

    }
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[allRssEntry objectAtIndex:indexPath.row].link]];
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}

-(void)startView{
       
    //    NSDMenuViewController * __weak menuV =(NSDMenuViewController *)[[NSDNavigatorController sharedInstance]leftMenu];
   
    
    
     
     if(_privateSelfUserFeed){
     NSString * title = [(NSDNavigatorController *)self.navigationController currentUser].userLogin;
        
        [self setTitle:[title stringByAppendingString:@"'s news"]];
    }

    
    if(_privateSelfUserFeed&&[self.gitApi hasToken]){
    
        [self privateUserFeedLoadWithCompletion:^(NSString *url) {
          
                _rssLink = url;
                _privateSelfUserFeed = NO;
                return [self startView];
           
          
        }];
        
    }
    //[NSURL URLWithString:_rssLink]
          NSError * error = nil;
        NSString * downloadedXML = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:_rssLink] encoding:NSUTF8StringEncoding error:&error];
        if(error) return;
        NSDictionary * responceDic = [_xmlParser dictionaryWithString:downloadedXML];
      //  NSLog(@"dictionary feeds %@",responceDic);
        NSArray * entryArray = [responceDic objectForKey:@"entry"];
       [self->allRssEntry removeAllObjects];
        for(int i=0;i<entryArray.count;i++){
        [self->allRssEntry addObject:[[NSDNewsRssEntry alloc] initWithDictinary:responceDic andIndex:i]];
       
        }
    
    dispatch_async(dispatch_get_main_queue(),  ^{
     
        [self.activityIndicator stopAnimating];
        [self.tableView reloadInputViews];
        [self.tableView reloadData];
        self.loaded = YES;
        self.tableView.alpha = 1.0;
    });
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
 //   [super viewDidAppear:animated];
//    if(self->allRssEntry.count==0){
//        [self startView];
//    }
}

-(void)privateUserFeedLoadWithCompletion:(void (^)(NSString * url))completion{
    [self.gitApi getCurrentUserFeedsRssWithCompletion:^(NSDictionary *responceDic, NSString *errorString) {
        if(_userActivity){
            
            completion([responceDic objectForKey:@"current_user_actor_url"]);
            return ;}
        else{
        completion([responceDic objectForKey:@"current_user_url"]);
        }
        
        
    }];
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

-(BOOL)slideNavigationControllerShouldDisplayLeftMenu{
    return YES;
}

-(BOOL)slideNavigationControllerShouldDisplayRightMenu{
    return NO;
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
