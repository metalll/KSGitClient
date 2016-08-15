//
//  NSDFeedCell.m
//  gitClient
//
//  Created by NullStackDev on 12.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDFeedCell.h"

@implementation NSDFeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _logo.layer.cornerRadius = 14;
    _logo.layer.masksToBounds = YES;
    _logo.layer.borderWidth = 0;
}

-(NSString *)reuseIdentifier{
    return @"feedCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
