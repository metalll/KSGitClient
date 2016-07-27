//
//  NSDUserCell.h
//  gitClient
//
//  Created by NullStackDev on 26.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDUserCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITextView *userName;
@property (weak, nonatomic) IBOutlet UITextView *userLogin;

@end
