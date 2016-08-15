//
//  NSDFeedCell.h
//  gitClient
//
//  Created by NullStackDev on 12.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDFeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIImageView *typeLogo;
@property (weak, nonatomic) IBOutlet UILabel *feedDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedContentLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *feedActivityIndicartor;

@end
