//
//  NSDUserCell.m
//  gitClient
//
//  Created by NullStackDev on 26.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDUserCell.h"

@implementation NSDUserCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _activityIndicator.hidesWhenStopped = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
 
}

@end
