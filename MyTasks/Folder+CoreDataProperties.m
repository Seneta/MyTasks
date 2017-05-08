//
//  Folder+CoreDataProperties.m
//  MyTasks
//
//  Created by Yurii Seneta on 5/8/17.
//  Copyright © 2017 Romanova Ksenia. All rights reserved.
//

#import "Folder+CoreDataProperties.h"

@implementation Folder (CoreDataProperties)

+ (NSFetchRequest<Folder *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Folder"];
}

@dynamic id;
@dynamic name;
@dynamic tasks;

@end
