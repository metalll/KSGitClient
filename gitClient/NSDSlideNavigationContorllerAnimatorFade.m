//
//  NSDSlideNavigationContorllerAnimatorFade.m
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDSlideNavigationContorllerAnimatorFade.h"

@interface NSDSlideNavigationContorllerAnimatorFade()
@property (nonatomic, strong) UIView *fadeAnimationView;
@end

@implementation NSDSlideNavigationContorllerAnimatorFade

#pragma mark - Initialization -

- (instancetype)init
{
    if (self = [self initWithMaximumFadeAlpha:.8 andFadeColor:[UIColor blackColor]])
    {
    }
    
    return self;
}

- (instancetype)initWithMaximumFadeAlpha:(CGFloat)maximumFadeAlpha andFadeColor:(UIColor *)fadeColor
{
    if (self = [super init])
    {
        self.maximumFadeAlpha = maximumFadeAlpha;
        self.fadeColor = fadeColor;
        
        self.fadeAnimationView = [[UIView alloc] init];
        self.fadeAnimationView.backgroundColor = self.fadeColor;
    }
    
    return self;
}

#pragma mark - SlideNavigationContorllerAnimation Methods -

- (void)prepareMenuForAnimation:(Menu)menu
{
    UIViewController *menuViewController = (menu == MenuLeft)
    ? [NSDSlideNavigationController sharedInstance].leftMenu
    : [NSDSlideNavigationController sharedInstance].rightMenu;
    
    self.fadeAnimationView.alpha = self.maximumFadeAlpha;
    self.fadeAnimationView.frame = menuViewController.view.bounds;
}

- (void)animateMenu:(Menu)menu withProgress:(CGFloat)progress
{
    UIViewController *menuViewController = (menu == MenuLeft)
    ? [NSDSlideNavigationController sharedInstance].leftMenu
    : [NSDSlideNavigationController sharedInstance].rightMenu;
    
    self.fadeAnimationView.frame = menuViewController.view.bounds;
    [menuViewController.view addSubview:self.fadeAnimationView];
    self.fadeAnimationView.alpha = self.maximumFadeAlpha - (self.maximumFadeAlpha *progress);
}

- (void)clear
{
    [self.fadeAnimationView removeFromSuperview];
}

@end
