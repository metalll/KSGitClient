//
//  NSDSlideNavigationContorllerAnimatorSlideAndFade.h
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDSlideNavigationContorllerAnimator.h"

@interface NSDSlideNavigationContorllerAnimatorSlideAndFade : NSObject <NSDSlideNavigationContorllerAnimator>
- (id)initWithMaximumFadeAlpha:(CGFloat)maximumFadeAlpha fadeColor:(UIColor *)fadeColor andSlideMovement:(CGFloat)slideMovement;
@end
