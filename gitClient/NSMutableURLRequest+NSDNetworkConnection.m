//
//  NSMutableURLRequest+NSDGitNetworkConnection.m
//  gitClient
//
//  Created by NullStackDev on 24.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSMutableURLRequest+NSDNetworkConnection.h"

@implementation NSMutableURLRequest (NSDGitNetworkConnection)

-(void)setBodyData:(NSData *)data isJSONData:(BOOL)isJSONData{
    
    self.HTTPBody = data;
    
    if(isJSONData) return;
    
    [self setValue: [NSString stringWithFormat:@"%li",data.length] forHTTPHeaderField:@"Content-Length"];
    
    NSString * log = [NSString stringWithFormat:@"%li",data.length];
    
    NSLog(@"%@",log);
    
    [self setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"application/x-www-form-urlencoded; charset=utf-8"];
    
    
    
}


@end
