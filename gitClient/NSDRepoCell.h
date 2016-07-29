//
//  NSDRepoCell.h
//  gitClient
//
//  Created by NullStackDev on 27.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDRepoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *repoImageView;
@property (weak, nonatomic) IBOutlet UILabel *lang;
@property (weak, nonatomic) IBOutlet UITextView *repoName;
@property (weak, nonatomic) IBOutlet UITextView *starCount;
@property NSString * cellID;
-(void)setIndetifireWithString:(NSString *)cellID;

@end
