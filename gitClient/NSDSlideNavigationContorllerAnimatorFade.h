//
//  NSDSlideNavigationContorllerAnimatorFade.h
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDSlideNavigationContorllerAnimator.h"

@interface NSDSlideNavigationContorllerAnimatorFade : NSObject <NSDSlideNavigationContorllerAnimator>
@property (nonatomic, assign) CGFloat maximumFadeAlpha;
@property (nonatomic, strong) UIColor *fadeColor;
- (instancetype)initWithMaximumFadeAlpha:(CGFloat)maximumFadeAlpha andFadeColor:(UIColor *)fadeColor;
@end
