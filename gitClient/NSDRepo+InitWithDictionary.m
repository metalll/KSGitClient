//
//  NSDRepo+InitWithDictionary.m
//  gitClient
//
//  Created by NullStackDev on 28.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDRepo+InitWithDictionary.h"

@implementation NSDRepo (InitWithDictionary)

- (NSDRepo *) initWithDictionary:(NSDictionary *)dictionary andIndex:(NSInteger)index{
    self = [super init];
    
    
    NSString * stringisRepo =[ NSString stringWithFormat:@"%@",[[(NSArray *)dictionary objectAtIndex:index] objectForKey:@"fork"]];
    if([stringisRepo isEqualToString:@"1"]){
        self.isFork = YES;
    }
    
    if(self){
    self.repoName = [[(NSArray *)dictionary objectAtIndex:index] objectForKey:@"name"];
    self.repoUrl = [[(NSArray *)dictionary objectAtIndex:index] objectForKey:@"html_url"];
    self.forks = [[(NSArray *) dictionary objectAtIndex:index] objectForKey:@"forks"];
    self.stars = [[(NSArray *)dictionary objectAtIndex:index]objectForKey:@"stargazers_count"] ;
    
    }
//    NSLog(@"repoName : %@",temp.repoName);
//    NSLog(@"repoURL : %@",temp.repoUrl);
//    NSLog(@"repoStars: %@",temp.stars);
//    NSLog(@"is fork %@",temp.isFork?@"YES":@"NO");
//    NSLog(@"repo forks : %@",temp.forks);

    
    
 
   
    
    
    
    return self;
}

@end
