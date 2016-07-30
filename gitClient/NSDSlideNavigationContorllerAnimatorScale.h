//
//  NSDSlideNavigationContorllerAnimatorScale.h
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDSlideNavigationContorllerAnimator.h"

@interface NSDSlideNavigationContorllerAnimatorScale : NSObject <NSDSlideNavigationContorllerAnimator>
@property (nonatomic, assign) CGFloat minimumScale;

- (instancetype)initWithMinimumScale:(CGFloat)minimumScale;

@end
