//
//  Folder+CoreDataProperties.h
//  MyTasks
//
//  Created by Yurii Seneta on 5/8/17.
//  Copyright © 2017 Romanova Ksenia. All rights reserved.
//

#import "Folder+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Folder (CoreDataProperties)

+ (NSFetchRequest<Folder *> *)fetchRequest;

@property (nonatomic) int32_t id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSOrderedSet<Task *> *tasks;

@end

@interface Folder (CoreDataGeneratedAccessors)

- (void)insertObject:(Task *)value inTasksAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTasksAtIndex:(NSUInteger)idx;
- (void)insertTasks:(NSArray<Task *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeTasksAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTasksAtIndex:(NSUInteger)idx withObject:(Task *)value;
- (void)replaceTasksAtIndexes:(NSIndexSet *)indexes withTasks:(NSArray<Task *> *)values;
- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSOrderedSet<Task *> *)values;
- (void)removeTasks:(NSOrderedSet<Task *> *)values;

@end

NS_ASSUME_NONNULL_END
