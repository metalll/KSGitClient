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
@interface NSDBaseViewController ()

@end

@implementation NSDBaseViewController

- (void)viewDidLoad {
    if(!NSDGitManager.hasToken){  // тыкс велосипед т.к viewWillAppear вызываеться после ViewDidload!!!
        NSLog(@"No token no auth");
    }
  
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
   
    [NSDGitManager getCurrentUserWithCompletion:^(NSDictionary *responceDic, NSString *errorString) {
        NSLog(@"%@",errorString);
        NSLog(@"%@",responceDic);
        
        
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0) return 0;
    
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NSDUserCell"owner:self options:nil];
    NSDUserCell * cell = [nib lastObject];
    
    
    return cell;
    
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
