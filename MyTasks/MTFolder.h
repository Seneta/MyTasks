//
//  MTFolder.h
//  MyTasks
//
//  Created by Seneta Yurii on 1/19/17.
//  Copyright © 2017 Romanova Ksenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTTask.h"

@interface MTFolder : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong, readonly) NSMutableArray *tasks;

- (void)addTask:(MTTask *)task;
- (void)removeTask:(int)index;
- (instancetype)initWithTitle:(NSString *)title;

@end
