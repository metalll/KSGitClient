//
//  NSDBaseViewController.m
//  gitClient
//
//  Created by NullStackDev on 11.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDBaseViewController.h"

@implementation NSDBaseViewController

-(instancetype)init{
    if((self = [super init])){
        _gitApi = [NSDGitManager sharedInstance];
        _cache = [NSDCacheController sharedInstance];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    _gitApi = [NSDGitManager sharedInstance];
    _cache = [NSDCacheController sharedInstance];
}

-(BOOL)slideNavigationControllerShouldDisplayRightMenu{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NO;
}

-(BOOL)slideNavigationControllerShouldDisplayLeftMenu{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NO;
}

-(void)startView{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

@end
