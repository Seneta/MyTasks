//
//  CompletedFolder+CoreDataProperties.m
//  MyTasks
//
//  Created by Yurii Seneta on 5/8/17.
//  Copyright © 2017 Romanova Ksenia. All rights reserved.
//

#import "CompletedFolder+CoreDataProperties.h"

@implementation CompletedFolder (CoreDataProperties)

+ (NSFetchRequest<CompletedFolder *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CompletedFolder"];
}

@dynamic name;
@dynamic tasks;

@end
