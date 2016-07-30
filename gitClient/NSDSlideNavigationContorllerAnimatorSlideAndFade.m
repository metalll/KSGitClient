//
//  NSDSlideNavigationContorllerAnimatorSlideAndFade.m
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDSlideNavigationContorllerAnimatorSlideAndFade.h"

#import "NSDSlideNavigationContorllerAnimatorSlideAndFade.h"
#import "NSDSlideNavigationContorllerAnimatorSlide.h"
#import "NSDSlideNavigationContorllerAnimatorFade.h"

@interface NSDSlideNavigationContorllerAnimatorSlideAndFade()
@property (nonatomic, strong) NSDSlideNavigationContorllerAnimatorFade *fadeAnimation;
@property (nonatomic, strong) NSDSlideNavigationContorllerAnimatorSlide *slideAnimation;
@end

@implementation NSDSlideNavigationContorllerAnimatorSlideAndFade

#pragma mark - Initialization -

- (instancetype)init
{
    if (self = [self initWithMaximumFadeAlpha:.8 fadeColor:[UIColor blackColor] andSlideMovement:100])
    {
    }
    
    return self;
}

- (instancetype)initWithMaximumFadeAlpha:(CGFloat)maximumFadeAlpha fadeColor:(UIColor *)fadeColor andSlideMovement:(CGFloat)slideMovement
{
    if (self = [super init])
    {
        self.fadeAnimation = [[NSDSlideNavigationContorllerAnimatorFade alloc] initWithMaximumFadeAlpha:maximumFadeAlpha andFadeColor:fadeColor];
        self.slideAnimation = [[NSDSlideNavigationContorllerAnimatorSlide alloc] initWithSlideMovement:slideMovement];
    }
    
    return self;
}

#pragma mark - SlideNavigationContorllerAnimation Methods -

- (void)prepareMenuForAnimation:(Menu)menu
{
    [self.fadeAnimation prepareMenuForAnimation:menu];
    [self.slideAnimation prepareMenuForAnimation:menu];
}

- (void)animateMenu:(Menu)menu withProgress:(CGFloat)progress
{
    [self.fadeAnimation animateMenu:menu withProgress:progress];
    [self.slideAnimation animateMenu:menu withProgress:progress];
}

- (void)clear
{
    [self.fadeAnimation clear];
    [self.slideAnimation clear];
}

@end