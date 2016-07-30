//
//  NSDSlideNavigationContorllerAnimatorScale.m
//  gitClient
//
//  Created by NullStackDev on 29.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDSlideNavigationContorllerAnimatorScale.h"

@implementation NSDSlideNavigationContorllerAnimatorScale

#pragma mark - Initialization -

- (instancetype)init
{
    if (self = [self initWithMinimumScale:.9])
    {
    }
    
    return self;
}

- (instancetype)initWithMinimumScale:(CGFloat)minimumScale
{
    if (self = [super init])
    {
        self.minimumScale = minimumScale;
    }
    
    return self;
}

#pragma mark - SlideNavigationContorllerAnimation Methods -

- (void)prepareMenuForAnimation:(Menu)menu
{
    UIViewController *menuViewController = (menu == MenuLeft)
    ? [NSDSlideNavigationController sharedInstance].leftMenu
    : [NSDSlideNavigationController sharedInstance].rightMenu;
    
    menuViewController.view.transform = CGAffineTransformScale(menuViewController.view.transform, self.minimumScale, self.minimumScale);
}

- (void)animateMenu:(Menu)menu withProgress:(CGFloat)progress
{
    UIViewController *menuViewController = (menu == MenuLeft)
    ? [NSDSlideNavigationController sharedInstance].leftMenu
    : [NSDSlideNavigationController sharedInstance].rightMenu;
    
    CGFloat scale = MIN(1, (1-self.minimumScale) *progress + self.minimumScale);
    menuViewController.view.transform = CGAffineTransformScale([NSDSlideNavigationController sharedInstance].view.transform, scale, scale);
}

- (void)clear
{
    [NSDSlideNavigationController sharedInstance].leftMenu.view.transform = CGAffineTransformScale([NSDSlideNavigationController sharedInstance].view.transform, 1, 1);
    [NSDSlideNavigationController sharedInstance].rightMenu.view.transform = CGAffineTransformScale([NSDSlideNavigationController sharedInstance].view.transform, 1, 1);
}

@end