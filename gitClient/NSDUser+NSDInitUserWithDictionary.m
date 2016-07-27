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
        self.userBio = [dictionary objectForKey:@"bio"];
        self.userLogin = [dictionary objectForKey:@"login"];
        self.userName = [dictionary objectForKey:@"name"];
        self.userPrivateRepoCount = [dictionary objectForKey:@"total_private_repos"];
        self.userPublicRepoCount = [dictionary objectForKey:@"public_repos"];
        self.userEmail = [dictionary objectForKey:@"metall112@bk.ru"];
        self.userAvatarURL = [dictionary objectForKey:@"avatar_url"];
        self.userCompany = [dictionary objectForKey:@"company"];
        self.userURL = [dictionary objectForKey:@"url"];
        self.userCollaborators = [dictionary objectForKey:@"collaborators"];
        self.eventsURL = [dictionary objectForKey:@"events_url"];
        self.reposURL = [dictionary objectForKey:@"repos_url"];
        
    }
    
    return self;
}

@end
