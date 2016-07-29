//
//  NSDSlideNavigationContorllerAnimator.h
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDSlideNavigatorController.h"


@protocol NSDSlideNavigationContorllerAnimator <NSObject>
- (void)prepareMenuForAnimation:(Menu)menu;
- (void)animateMenu:(Menu)menu withProgress:(CGFloat)progress;
- (void)clear;
@end
