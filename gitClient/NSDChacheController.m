//
//  NSDChacheController.m
//  gitClient
//
//  Created by NullStackDev on 24.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDChacheController.h"
#import <UIKit/UIKit.h>
#import "NSDGitManager.h"
@implementation NSDChacheController{
NSMutableDictionary *cacheDic;
NSMutableArray *array;
NSUInteger size;
}



- (NSMutableDictionary *)dic {
    return self->cacheDic;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        cacheDic = [NSMutableDictionary dictionary];
        array = [NSMutableArray array];
    }
    return self;
}

- (void)objectForKey:(id)key andCompletion:(void (^)(id object))completion {
    id retVal =[[self dic] objectForKey:key];
    if(retVal!=nil && completion!=nil){
        completion(retVal);
        return;
    }
    
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:key] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(!error && data){
            UIImage * retVal = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setObject:retVal forKey:key ofLength:data.length];
                completion(retVal);
                return;
            });
          
        }
        
        
    }]resume];
    
}


- (void)setObject:(id)object forKey:(id<NSCopying>)key ofLength:(NSUInteger)length {
    
    @synchronized(self) {
        
        if (self->size >= 1000 * 1000 * 25) {
            
            NSUInteger minusSize = 0;
            NSUInteger expectedHalfSize = self->size / 2;
            NSUInteger i = 0;
            for (; i < [self->array count]; i++) {
                id dic = self->array[i];
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    minusSize += [dic[@"length"] unsignedIntegerValue];
                    [self->cacheDic removeObjectForKey:dic[@"key"]];
                    if (minusSize >= expectedHalfSize) {
                        break;
                    }
                }
            }
            
            [self->array removeObjectsInRange:NSMakeRange(0, i + 1)];
            
            self->size -= minusSize;
        }
        
        [self->cacheDic setObject:object forKey:key];
        [self->array addObject:@{@"key": key, @"length": @(length)}];
        self->size += length;
    }
}
@end
