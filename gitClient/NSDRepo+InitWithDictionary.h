//
//  NSDRepo+InitWithDictionary.h
//  gitClient
//
//  Created by NullStackDev on 28.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDRepo.h"

@interface NSDRepo (InitWithDictionary)
- (NSDRepo *) initWithDictionary:(NSDictionary *)dictionary andIndex:(NSInteger)index;

@end
