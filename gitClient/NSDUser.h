//
//  NSDUser.h
//  gitClient
//
//  Created by NullStackDev on 26.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDUser : NSObject
//this field will be to UI
@property NSString * userBio;
@property NSString * userLogin;
@property NSString * userPublicRepoCount;
@property NSString * userPrivateRepoCount;
@property NSString * userEmail;
@property NSString * userName;
@property NSString * userAvatarURL;
@property NSString * userCompany;
@property NSString * userCollaborators;

@property NSString * starredCount;
@property NSString * starredURL;

@property NSString * followingCount ;
@property NSString * followingURL;

@property NSString * followersCount;
@property NSString * followersURL;

@property NSString * joinedOn;

//other fields
@property NSString * eventsURL;
@property NSString * reposURL;
@property NSString * userURL;

@end
