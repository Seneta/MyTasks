//
//  MTFolder.m
//  MyTasks
//
//  Created by Seneta Yurii on 1/19/17.
//  Copyright © 2017 Romanova Ksenia. All rights reserved.
//

#import "MTFolder.h"
@interface MTFolder()

@property (nonatomic, strong) NSMutableArray *tasks;

@end


@implementation MTFolder

- (NSMutableArray *)tasks {
    if (nil != _tasks) {
        return _tasks;
    }
    
    _tasks = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; ++i) {
        NSDictionary *testTaskDictionary = @{ @"title" :@"Test" ,
                                              @"descriptions" :@"Its description of your important task, now complete it ASAP!",
                                              @"date" :[NSDate date],
                                              @"priority" :[NSNumber numberWithInt:1]};
        MTTask *newTask = [[MTTask alloc] initWithDictionary:testTaskDictionary];
        [_tasks addObject:newTask];
    }
    
    return _tasks;
}

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    self.title = title;
    
    return self;
}

- (void)addTask:(MTTask *)task {
    [self.tasks addObject:task];
}

- (void)removeTask:(int)index {
    [self.tasks removeObjectAtIndex:index];
}

@end
