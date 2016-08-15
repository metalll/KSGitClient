//
//  NSDNotification.m
//  gitClient
//
//  Created by NullStackDev on 14.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDNotification.h"

@implementation NSDNotification


-(instancetype)initWithDictionary:(NSDictionary *)dictionary andIndex:(NSInteger)index{
    
    self = [super init];
    
    
    
    if(self){
        NSLog(@"dictionary %@",dictionary);
        self.authorAvatarUrl = nil;
        self.firstTitle =[[[(NSArray *)dictionary objectAtIndex:index] objectForKey:@"repository"] objectForKey:@"name"];
        self.updatedAt = [[(NSArray *)dictionary objectAtIndex:index] objectForKey:@"updated_at"];
        self.typeTitle = [[[(NSArray *)dictionary objectAtIndex:index] objectForKey:@"subject"] objectForKey:@"title"];
        self.type = [[[(NSArray *)dictionary objectAtIndex:index] objectForKey:@"subject"] objectForKey:@"type"];
        self.notifURL = [[[(NSArray *)dictionary objectAtIndex:index] objectForKey:@"subject"] objectForKey:@"url"];
        NSLog(@"firstTitle %@",self.firstTitle );
        
    }

    return self;
}


@end
