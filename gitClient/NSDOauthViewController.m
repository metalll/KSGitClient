//
//  NSDOauthViewController.m
//  gitClient
//
//  Created by NullStackDev on 24.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDOauthViewController.h"
#import "NSDictionary+NSDNetworkConnection.h"
#import "NSURL+NSDNetworkConnection.h"
#import "NSDGitManager.h"
@interface NSDOauthViewController ()

@end

@implementation NSDOauthViewController



- (void)viewDidLoad {
   [super viewDidLoad];
   
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"token"]!=nil){
        NSLog(@"I am have token! We're talking authorization? Not today!");
        
        
    }
    
    
    NSLog(@"AUTH step 1 give me requested code");
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/login/oauth/authorize?client_id=90148ae988fcef1f0bb3&scope=user,repo" ]]];
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    _webView.alpha = 0;
    [_activityIndicator startAnimating];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [UIView animateWithDuration:0.2 animations:^{
        _webView.alpha = 1;
    } completion:^(BOOL finished) {
        [_activityIndicator stopAnimating];
    }];


}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
     NSLog(@"%@",request.URL);
  
    //need request's (лучше пропустить код до след коментария т.к код ниже жуткий костыль)
    if([[NSString stringWithFormat:@"%@",request.URL] isEqualToString:@"https://github.com/login?client_id=90148ae988fcef1f0bb3&return_to=%2Flogin%2Foauth%2Fauthorize%3Fclient_id%3D90148ae988fcef1f0bb3%26scope%3Duser%252Crepo"]||[[NSString stringWithFormat:@"%@",request.URL] isEqualToString:@"https://github.com/login/oauth/authorize?client_id=90148ae988fcef1f0bb3&scope=user,repo"]||
       [[NSString stringWithFormat:@"%@",request.URL] isEqualToString:@"https://github.com/session"]||
       [[NSString stringWithFormat:@"%@",request.URL] isEqualToString:@"https://github.com/login/oauth/authorize"]||
       [[NSString stringWithFormat:@"%@",request.URL] isEqualToString:@"https://github.com/login/oauth/authorize?client_id=90148ae988fcef1f0bb3&scope=user%2Crepo"]){ return YES; }
   
    NSDictionary * dic = [request.URL dictionaryFromURL];
    if(dic!=nil){
        if([dic objectForKey:@"code"]!=nil){
            [[NSDGitManager sharedInstance]processOAuthWithCallbackURL:request.URL]; //bingo!!! get over here f****** code!
            return NO;
        }
        if([dic objectForKey:@"return_to"]!=nil){ return NO;}
    }
       
    //if data don't assign to oauth opened content with safari
    [[UIApplication sharedApplication] openURL:request.URL] ;
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
