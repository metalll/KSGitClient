//
//  NSDUser+NSDInitUserWithDictionary.m
//  gitClient
//
//  Created by NullStackDev on 26.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDUser+NSDInitUserWithDictionary.h"

@implementation NSDUser (NSDInitUserWithDictionary)

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    
    if(self){
        
        NSLog(@"%@",dictionary);
        @try {
             self.userBio = [dictionary objectForKey:@"bio"];
        }
        @catch (NSException *exception) {
            self.userBio = nil;
        }
        
        @try {
            self.userLogin = [dictionary objectForKey:@"login"];
        }
        @catch (NSException *exception) {
            self.userLogin = nil;
        }
        @try {
          self.userName = [dictionary objectForKey:@"name"];
        }
        @catch (NSException *exception) {
            self.userName =nil;
        }
        

        
       
        
        
        self.userPrivateRepoCount = [dictionary objectForKey:@"total_private_repos"];
        self.userPublicRepoCount = [dictionary objectForKey:@"public_repos"];
        self.userEmail = [dictionary objectForKey:@"email"];
        self.userAvatarURL = [dictionary objectForKey:@"avatar_url"];
        self.userCompany = [dictionary objectForKey:@"company"];
        self.userURL = [dictionary objectForKey:@"url"];
        self.userCollaborators = [dictionary objectForKey:@"collaborators"];
        self.eventsURL = [dictionary objectForKey:@"events_url"];
        self.reposURL = [dictionary objectForKey:@"repos_url"];
        self.joinedOn = [dictionary objectForKey:@"created_at"];
        self.followersCount = [dictionary objectForKey:@"followers"];
        self.followersURL = [dictionary objectForKey:@"followers_url"];
        self.followingCount = [dictionary objectForKey:@"following"];
        self.followingURL = [dictionary objectForKey:@"following_url"];
        self.starredURL  = [dictionary objectForKey:@"starred_url"];
        
        
    }
    
    return self;
}

@end
