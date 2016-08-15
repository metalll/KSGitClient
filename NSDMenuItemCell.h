//
//  NSDMenuItemCell.h
//  gitClient
//
//  Created by NullStackDev on 12.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDMenuItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *menuLabel;
@property (weak, nonatomic) IBOutlet UIImageView *menuLogo;

@end
