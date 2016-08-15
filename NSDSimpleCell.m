//
//  NSDSimpleCell.m
//  gitClient
//
//  Created by NullStackDev on 14.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDSimpleCell.h"

@implementation NSDSimpleCell

- (void)awakeFromNib {
    
}
-(NSString *)reuseIdentifier{
    return @"simpleCell";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
