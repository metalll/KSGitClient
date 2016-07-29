//
//  NSDSlideNavigationContorllerAnimatorSlide.h
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDSlideNavigationContorllerAnimator.h"

@interface NSDSlideNavigationContorllerAnimatorSlide : NSObject <NSDSlideNavigationContorllerAnimator>

@property (nonatomic, assign) CGFloat slideMovement;

- (id)initWithSlideMovement:(CGFloat)slideMovement;

@end
