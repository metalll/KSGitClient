//
//  NSDSlideNavigationContorllerAnimatorSlide.m
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//



#import "NSDSlideNavigationContorllerAnimatorSlide.h"

@implementation NSDSlideNavigationContorllerAnimatorSlide

#pragma mark - Initialization -

- (instancetype)init
{
    if (self = [self initWithSlideMovement:100])
    {
    }
    
    return self;
}

- (instancetype)initWithSlideMovement:(CGFloat)slideMovement
{
    if (self = [super init])
    {
        self.slideMovement = slideMovement;
    }
    
    return self;
}

#pragma mark - SlideNavigationContorllerAnimation Methods -

- (void)prepareMenuForAnimation:(Menu)menu
{
    UIViewController *menuViewController = (menu == MenuLeft)
    ? [NSDSlideNavigationController sharedInstance].leftMenu
    : [NSDSlideNavigationController sharedInstance].rightMenu;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    CGRect rect = menuViewController.view.frame;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        rect.origin.x = (menu == MenuLeft) ? self.slideMovement*-1 : self.slideMovement;
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            if (orientation == UIInterfaceOrientationLandscapeRight)
            {
                rect.origin.y = (menu == MenuLeft) ? self.slideMovement*-1 : self.slideMovement;
            }
            else
            {
                rect.origin.y = (menu == MenuRight) ? self.slideMovement*-1 : self.slideMovement;
            }
        }
        else
        {
            if (orientation == UIInterfaceOrientationPortrait)
            {
                rect.origin.x = (menu == MenuLeft) ? self.slideMovement*-1 : self.slideMovement;
            }
            else
            {
                rect.origin.x = (menu == MenuRight) ? self.slideMovement*-1 : self.slideMovement;
            }
        }
    }
    
    menuViewController.view.frame = rect;
}

- (void)animateMenu:(Menu)menu withProgress:(CGFloat)progress
{
    UIViewController *menuViewController = (menu == MenuLeft)
    ? [NSDSlideNavigationController sharedInstance].leftMenu
    : [NSDSlideNavigationController sharedInstance].rightMenu;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    NSInteger location = (menu == MenuLeft)
    ? (self.slideMovement * -1) + (self.slideMovement * progress)
    : (self.slideMovement * (1-progress));
    
    if (menu == MenuLeft)
        location = (location > 0) ? 0 : location;
    
    if (menu == MenuRight)
        location = (location < 0) ? 0 : location;
    
    CGRect rect = menuViewController.view.frame;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        rect.origin.x = location;
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            rect.origin.y = (orientation == UIInterfaceOrientationLandscapeRight) ? location : location*-1;
        }
        else
        {
            rect.origin.x = (orientation == UIInterfaceOrientationPortrait) ? location : location*-1;
        }
    }
    
    menuViewController.view.frame = rect;
}

- (void)clear
{
    [self clearMenu:MenuLeft];
    [self clearMenu:MenuRight];
}

#pragma mark - Private Method -

- (void)clearMenu:(Menu)menu
{
    UIViewController *menuViewController = (menu == MenuLeft)
    ? [NSDSlideNavigationController sharedInstance].leftMenu
    : [NSDSlideNavigationController sharedInstance].rightMenu;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    CGRect rect = menuViewController.view.frame;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        rect.origin.x = 0;
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            rect.origin.y = 0;
        }
        else
        {
            rect.origin.x = 0;
        }
    }
    
    menuViewController.view.frame = rect;
}

@end