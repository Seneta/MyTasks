//
//  MTTasksHolder.m
//  MyTasks
//
//  Created by Seneta Yuriy on 26.09.16.
//  Copyright © 2016 Romanova Ksenia. All rights reserved.
//

#import "MTTasksHolder.h"
#import "MTFolder.h"
#import "MTTask.h"

@interface MTTasksHolder()

@property (nonatomic, strong) NSMutableArray *folders;

@end

@implementation MTTasksHolder

- (NSMutableArray *)folders {
    if (nil != _folders) {
        return _folders;
    }
    
    _folders = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; ++i) {
        MTFolder *newFolder = [[MTFolder alloc] initWithTitle:[NSString stringWithFormat:@"Folder #%d", i]];
        [_folders addObject:newFolder];
    }
    
    return _folders;
}

+ (MTTasksHolder *)holder {
    static MTTasksHolder *holder = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        holder = [[self alloc] init];
    });
    return holder;
}

- (void)addNewFolder:(NSString *)title {
    MTFolder *newFolder = [[MTFolder alloc] initWithTitle:title];
    [self.folders addObject:newFolder];
}

- (void)removeFolder:(int)index {
    [self.folders removeObjectAtIndex:index];
}


@end
