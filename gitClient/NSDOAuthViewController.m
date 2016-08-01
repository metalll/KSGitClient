//
//  NSDOAuthViewController.m
//  gitClient
//
//  Created by NullStackDev on 25.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDOAuthViewController.h"
#import "NSDGitManager.h"
#import "NSURL+NSDNetworkConnection.h"
#import "NSDBaseNavigatorController.h"
@interface NSDOAuthViewController ()

@end

@implementation NSDOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _indicatorView.hidesWhenStopped = YES;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadURL]]];
    _webView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%@",request);
    
    if([[NSString stringWithFormat:@"%@",request.URL] isEqualToString:@"https://github.com/login/oauth/authorize?client_id=90148ae988fcef1f0bb3&scope=user,repo,notifications"]||[[NSString stringWithFormat:@"%@",request.URL] isEqualToString:@"https://github.com/login?client_id=90148ae988fcef1f0bb3&return_to=%2Flogin%2Foauth%2Fauthorize%3Fclient_id%3D90148ae988fcef1f0bb3%26scope%3Duser%252Crepo%252Cnotifications"]||[[NSString stringWithFormat:@"%@",request.URL] isEqualToString:@"https://github.com/session"]||[[NSString stringWithFormat:@"%@",request.URL] isEqualToString:@"https://github.com/login/oauth/authorize?client_id=90148ae988fcef1f0bb3&scope=user%2Crepo%2Cnotifications"]||[[NSString stringWithFormat:@"%@",request.URL] isEqualToString:@"https://github.com/login/oauth/authorize"]) return YES;
    
    if([[request.URL dictionaryFromURL] objectForKey:@"code"]!=nil){
        
        
        [[[NSDBaseNavigatorController sharedInstance] gitApi] processOAuth2WithCallbackURI:request.URL andCompletion:^{
            
            
            [[NSDBaseNavigatorController sharedInstance] initUser];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];

        return NO;
    }
    
    [UIApplication.sharedApplication openURL:request.URL];
    return NO;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [_indicatorView stopAnimating];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_webView stopLoading];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    [_indicatorView startAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No internet connection"
                                                                   message:@"Check your network connection"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {  }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
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
