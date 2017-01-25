//
//  MTTasksHolder.h
//  MyTasks
//
//  Created by Seneta Yuriy on 26.09.16.
//  Copyright © 2016 Romanova Ksenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTTasksHolder : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *folders;

+ (MTTasksHolder *)holder;
- (void)addNewFolder:(NSString *)title;
- (void)removeFolder:(int)index;

@end
