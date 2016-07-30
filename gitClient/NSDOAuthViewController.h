//
//  NSDOAuthViewController.h
//  gitClient
//
//  Created by NullStackDev on 25.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDOAuthViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property NSString * loadURL;
@end
