//
//  NSDNewsRssEntry.m
//  gitClient
//
//  Created by NullStackDev on 07.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDNewsRssEntry.h"

@implementation NSDNewsRssEntry

-(id)initWithDictinary:(NSDictionary *)dictionary andIndex:(NSInteger)index{
    
    self = [super init];
    NSArray * entryArray = [dictionary objectForKey:@"entry"];
    if(self){
        
        _authorAvatarUrl = [[[entryArray objectAtIndex:index] objectForKey:@"media:thumbnail"] objectForKey:@"_url"];
        
        _content = [[[entryArray objectAtIndex:index] objectForKey:@"title"] objectForKey:@"__text"];
        _link = [[[entryArray objectAtIndex:index]objectForKey:@"link"] objectForKey:@"_href"];
        _published = [[entryArray objectAtIndex:index] objectForKey:@"published"];
        
        if ([_content rangeOfString:@"starred"].location != NSNotFound) {
            _type = @"star";
        }
        if ([_content rangeOfString:@"forked"].location != NSNotFound) {
            _type = @"fork";
        }
        if ([_content rangeOfString:@"commented"].location != NSNotFound) {
            _type = @"comment";
        }
        if([_content rangeOfString:@"pushed"].location !=NSNotFound){
            _type = @"push";
        }
        if([_content rangeOfString:@"merged"].location !=NSNotFound){
            _type = @"merge";
        }
        
        if([_content rangeOfString:@"created"].location !=NSNotFound){
            if([_content rangeOfString:@"repository"].location !=NSNotFound){
                _type = @"createdRepo";
            };
            if([_content rangeOfString:@"branch"].location !=NSNotFound){
                _type = @"createdBranch";
            };
        }
        if([_content rangeOfString:@"issue"].location !=NSNotFound){
            if([_content rangeOfString:@"opened"].location !=NSNotFound){
                _type = @"oIssue";
            };
            if([_content rangeOfString:@"closed"].location !=NSNotFound){
                _type = @"cIssue";
            };
        }

       
    }
    
//    NSLog(@"author avatar url %@",_authorAvatarUrl);
//    NSLog(@"content %@",_content);
//    NSLog(@"link %@",_link);
//    NSLog(@" publicshed %@", _published);
//    NSLog(@"type %@",_type);
    
    return self;

}
@end
