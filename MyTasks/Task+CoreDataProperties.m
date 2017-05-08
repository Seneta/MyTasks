//
//  Task+CoreDataProperties.m
//  MyTasks
//
//  Created by Yurii Seneta on 5/8/17.
//  Copyright © 2017 Romanova Ksenia. All rights reserved.
//

#import "Task+CoreDataProperties.h"

@implementation Task (CoreDataProperties)

+ (NSFetchRequest<Task *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Task"];
}

@dynamic date;
@dynamic descriptions;
@dynamic id;
@dynamic name;
@dynamic priority;
@dynamic folder;
@dynamic completedFolder;

@end
