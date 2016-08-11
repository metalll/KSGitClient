//
//  NSDNewsViewController.m
//  gitClient
//
//  Created by NullStackDev on 06.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDNewsViewController.h"
#import "NSDNewsRssEntry.h"

@interface NSDNewsViewController(){
    NSMutableArray * allRssEntry;
}
@end

@implementation NSDNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _xmlParser = [NSDXMLParser sharedInstance];
  
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    self->allRssEntry = [NSMutableArray new];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0) return self->allRssEntry.count;
    return 0;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


-(void)startView{
    if(_privateSelfUserFeed){
    
        [self privateUserFeedLoadWithCompletion:^(NSString *url) {
            _rssLink = url;
            _privateSelfUserFeed = NO;
            return [self startView];
        }];
        
    }
          NSError * error = nil;
        NSString * downloadedXML = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:_rssLink] encoding:NSUTF8StringEncoding error:&error];
        if(error) return;
        NSDictionary * responceDic = [_xmlParser dictionaryWithString:downloadedXML];
        NSLog(@"dictionary feeds %@",responceDic);
    
    
    
    
    
}


-(void)privateUserFeedLoadWithCompletion:(void (^)(NSString * url))completion{
    [self.gitApi getCurrentUserFeedsRssWithCompletion:^(NSDictionary *responceDic, NSString *errorString) {
       
        completion([responceDic objectForKey:@"current_user_url"]);
        
    }];
}


-(BOOL)slideNavigationControllerShouldDisplayLeftMenu{
    return YES;
}

-(BOOL)slideNavigationControllerShouldDisplayRightMenu{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startView];
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
