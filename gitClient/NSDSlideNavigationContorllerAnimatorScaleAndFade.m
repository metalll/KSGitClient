//
//  SlideNavigationContorllerAnimatorScaleAndFade.m
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDSlideNavigationContorllerAnimatorScaleAndFade.h"


#import "NSDSlideNavigationContorllerAnimatorFade.h"
#import "NSDSlideNavigationContorllerAnimatorScale.h"

@interface NSDSlideNavigationContorllerAnimatorScaleAndFade()
@property (nonatomic, strong) NSDSlideNavigationContorllerAnimatorFade *fadeAnimation;
@property (nonatomic, strong) NSDSlideNavigationContorllerAnimatorScale *scaleAnimation;
@end

@implementation NSDSlideNavigationContorllerAnimatorScaleAndFade

#pragma mark - Initialization -

- (instancetype)init
{
    if (self = [self initWithMaximumFadeAlpha:.8 fadeColor:[UIColor blackColor] andMinimumScale:.8])
    {
    }
    
    return self;
}

- (id)initWithMaximumFadeAlpha:(CGFloat)maximumFadeAlpha fadeColor:(UIColor *)fadeColor andMinimumScale:(CGFloat)minimumScale
{
    if (self = [super init])
    {
        self.fadeAnimation = [[NSDSlideNavigationContorllerAnimatorFade alloc] initWithMaximumFadeAlpha:maximumFadeAlpha andFadeColor:fadeColor];
        self.scaleAnimation = [[NSDSlideNavigationContorllerAnimatorScale alloc] initWithMinimumScale:minimumScale];
    }
    
    return self;
}

#pragma mark - SlideNavigationContorllerAnimation Methods -

- (void)prepareMenuForAnimation:(Menu)menu
{
    [self.fadeAnimation prepareMenuForAnimation:menu];
    [self.scaleAnimation prepareMenuForAnimation:menu];
}

- (void)animateMenu:(Menu)menu withProgress:(CGFloat)progress
{
    [self.fadeAnimation animateMenu:menu withProgress:progress];
    [self.scaleAnimation animateMenu:menu withProgress:progress];
}

- (void)clear
{
    [self.fadeAnimation clear];
    [self.scaleAnimation clear];
}

@end
