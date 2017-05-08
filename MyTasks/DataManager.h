//
//  DataManager.h
//  MyTasks
//
//  Created by Yurii Seneta on 5/7/17.
//  Copyright © 2017 Romanova Ksenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Folder+CoreDataClass.h"
#import "Folder+CoreDataProperties.h"
#import "Task+CoreDataClass.h"
#import "Task+CoreDataProperties.h"
#import "CompletedFolder+CoreDataClass.h"
#import "CompletedFolder+CoreDataProperties.h"

@interface DataManager : NSObject

+ (void)createFolder:(NSString *) name;
+ (void)removeFolder:(Folder *) folder;
+ (NSArray*)getFolders;
+ (NSNumber*)getPlannedTaskForDate:(NSDate*)date;
+ (void)completeTask:(Task*)task;

@end
