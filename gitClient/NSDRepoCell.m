//
//  NSDRepoCell.m
//  gitClient
//
//  Created by NullStackDev on 27.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDRepoCell.h"

@interface NSDRepoCell ()

@end

@implementation NSDRepoCell
- (void)awakeFromNib {
    [super awakeFromNib];
    
        
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
        
}

-(void)setIndetifireWithString:(NSString *)cellID
{
    self.cellID = cellID;
}

-(NSString *)reuseIdentifier{
    return self.cellID;
}

@end
