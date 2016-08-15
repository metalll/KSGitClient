//
//  NSDSimpleCell.h
//  gitClient
//
//  Created by NullStackDev on 14.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSDSimpleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *simpleName;
@property (weak, nonatomic) IBOutlet UILabel *SimpleCount;
@end
