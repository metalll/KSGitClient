//
//  NSMutableURLRequest+NSDGitNetworkConnection.h
//  gitClient
//
//  Created by NullStackDev on 24.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (NSDGitNetworkConnection)

-(void) setBodyData:(NSData *)data isJSONData:(BOOL) isJSONData;

@end
