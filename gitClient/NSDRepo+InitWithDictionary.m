//
//  NSDRepo+InitWithDictionary.m
//  gitClient
//
//  Created by NullStackDev on 28.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDRepo+InitWithDictionary.h"

@implementation NSDRepo (InitWithDictionary)

+(id)initWithDictionary:(NSDictionary *)dictionary{
    NSMutableArray * retVal = [NSMutableArray new];
   
    
    
    for(int i = 0;i<dictionary.count;i++){
        NSDRepo * temp = [NSDRepo new];
    
        NSString * stringisRepo =[ NSString stringWithFormat:@"%@",[[(NSArray *)dictionary objectAtIndex:i] objectForKey:@"fork"]];
        if([stringisRepo isEqualToString:@"1"]){
            temp.isFork = YES;
        }
        
        
        temp.repoName = [[(NSArray *)dictionary objectAtIndex:i] objectForKey:@"name"];
        temp.repoUrl = [[(NSArray *)dictionary objectAtIndex:i] objectForKey:@"html_url"];
        temp.forks = [[(NSArray *) dictionary objectAtIndex:i] objectForKey:@"forks"];
        temp.stars = [[(NSArray *)dictionary objectAtIndex:i]objectForKey:@"stargazers_count"] ;
        
        NSLog(@"repoName : %@",temp.repoName);
        NSLog(@"repoURL : %@",temp.repoUrl);
        NSLog(@"repoStars: %@",temp.stars);
        NSLog(@"is fork %@",temp.isFork?@"YES":@"NO");
        NSLog(@"repo forks : %@",temp.forks);
        [retVal addObject:temp];
    }
   
    
    
    
    return retVal;
}

@end
