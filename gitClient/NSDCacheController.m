//
//  NSDChacheController.m
//  gitClient
//
//  Created by NullStackDev on 24.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDCacheController.h"
#import <UIKit/UIKit.h>
#import "NSDGitManager.h"

#define DOCUMENTS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
@implementation NSDCacheController{
NSMutableDictionary *cacheDic;
NSMutableArray *array;
NSUInteger size;
}


+(instancetype)sharedInstance{
    static NSDCacheController * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        instance = [[NSDCacheController alloc] init];
    });
    
    
    return instance;
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
    if(retVal && completion){
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
