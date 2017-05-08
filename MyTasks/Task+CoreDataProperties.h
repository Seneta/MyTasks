//
//  Task+CoreDataProperties.h
//  MyTasks
//
//  Created by Yurii Seneta on 5/8/17.
//  Copyright © 2017 Romanova Ksenia. All rights reserved.
//

#import "Task+CoreDataClass.h"
#import "CompletedFolder+CoreDataClass.h"
#import "Folder+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Task (CoreDataProperties)

+ (NSFetchRequest<Task *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *descriptions;
@property (nonatomic) int32_t id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic)  NSNumber* priority;
@property (nullable, nonatomic, retain) Folder *folder;
@property (nullable, nonatomic, retain) CompletedFolder *completedFolder;

@end

NS_ASSUME_NONNULL_END
