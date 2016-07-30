//
//  NSDNetworkController.h
//  gitClient
//
//  Created by NullStackDev on 25.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDNetworkController : NSObject


@property NSString * token;
@property NSString * baseURL;
@property NSURLSession * urlSession;
    
-(NSString *)processResponceWithResponce:(NSURLResponse *)responce andError:(NSError *)error;
-(void)downloadResourceWithURLString:(NSString *)url andCompletion:(void(^)(NSString * localPath,NSString * errorString)) completion;
-(void)performRequestWithURLPath:(NSString *)urlPath
                       andMethod:(NSString *)method
                       andParams:(NSDictionary *)params
           andAcceptJSONResponse:(BOOL) acceptJSONResponse
               andSendBodyAsJSON:(BOOL)sendBodyAsJSON
                   andCompletion:(void(^)(NSData * data,NSString * errorString))completion;

-(void) performRequestWithURLString:(NSString *)url
                          andMethod:(NSString *)method
                          andParams:(NSDictionary *)params
              andAcceptJSONResponse:(BOOL) acceptJSONResponse
                  andSendBodyAsJSON:(BOOL)sendBodyAsJSON
                      andCompletion:(void(^)(NSData * data,NSString * errorString))completion;


@end
