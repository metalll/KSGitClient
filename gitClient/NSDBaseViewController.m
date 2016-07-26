//
//  NSDBaseViewController.m
//  gitClient
//
//  Created by NullStackDev on 25.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDBaseViewController.h"
#import "NSDGitManager.h"
@interface NSDBaseViewController ()

@end

@implementation NSDBaseViewController

- (void)viewDidLoad {
    if(!NSDGitManager.hasToken) return;
  
    [super viewDidLoad];
   
    [NSDGitManager getCurrentUserWithCompletion:^(NSDictionary *responceDic, NSString *errorString) {
        NSLog(@"%@",errorString);
        NSLog(@"%@",responceDic);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!NSDGitManager.hasToken){
        UIViewController * auth = [self.storyboard instantiateViewControllerWithIdentifier:@"Auth"];
        
        [self.navigationController presentViewController:auth animated:NO completion:nil];
    }
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
