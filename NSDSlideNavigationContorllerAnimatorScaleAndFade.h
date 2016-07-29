//
//  SlideNavigationContorllerAnimatorScaleAndFade.h
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDSlideNavigationContorllerAnimator.h"

@interface NSDSlideNavigationContorllerAnimatorScaleAndFade : NSObject <NSDSlideNavigationContorllerAnimator>
- (instancetype)initWithMaximumFadeAlpha:(CGFloat)maximumFadeAlpha fadeColor:(UIColor *)fadeColor andMinimumScale:(CGFloat)minimumScale;
@end
