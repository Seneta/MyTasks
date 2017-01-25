//
//  MTTask.m
//  MyTasks
//
//  Created by Seneta Yuriy on 26.09.16.
//  Copyright © 2016 Romanova Ksenia. All rights reserved.
//

#import "MTTask.h"

@implementation MTTask

- (instancetype)initWithDictionary:(NSDictionary *)taskInfo {
    if (taskInfo == nil)
        return nil;
    
    self = [super init];
    if (self == nil)
        return self;
    
    self.title = taskInfo[@"title"] ? taskInfo[@"title"] : @"TEST";
    self.descriptions = taskInfo[@"descriptions"] ? taskInfo[@"descriptions"] : @"DESCRIPTIONS";
    self.deadlineDate = taskInfo[@"date"] ? taskInfo[@"date"] : [NSDate date];
    self.priority = taskInfo[@"priority"] ? taskInfo[@"priority"] : [NSNumber numberWithInt:1];
    return self;
}

@end
