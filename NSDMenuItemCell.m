//
//  NSDMenuItemCell.m
//  gitClient
//
//  Created by NullStackDev on 12.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDMenuItemCell.h"

@implementation NSDMenuItemCell

- (void)awakeFromNib {
    // Initialization code
}
-(NSString *)reuseIdentifier{
    return @"menuCell";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
