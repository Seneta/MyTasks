//
//  DataManager.m
//  MyTasks
//
//  Created by Yurii Seneta on 5/7/17.
//  Copyright © 2017 Romanova Ksenia. All rights reserved.
//

#import "DataManager.h"
#import <CoreData/CoreData.h>
#import "CoreDataStack.h"

@implementation DataManager

+ (void)completeTask:(Task*)task {
    NSArray* fetchedFolders = [[NSArray alloc] init];
    NSManagedObjectContext* context = CoreDataStack.sharedStack.managedObjectContext;
    
    @try{
        NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"CompletedFolder"];
        NSError *error;
        fetchedFolders = [context executeFetchRequest:request error:&error];
    }
    @catch (NSException * error) {
        
    }
    CompletedFolder *folder;
    
    if (fetchedFolders.count == 0) {
        NSEntityDescription* entity = [NSEntityDescription entityForName:@"CompletedFolder" inManagedObjectContext:context];
        folder = [[CompletedFolder alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    }
    else {
        folder = fetchedFolders[0];
    }
    
    [folder addTasksObject:task];
    [CoreDataStack.sharedStack saveContext];
}

+ (void)createFolder:(NSString *) name {
    NSManagedObjectContext* context = CoreDataStack.sharedStack.managedObjectContext;
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Folder" inManagedObjectContext:context];
    Folder* folder = [[Folder alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    folder.name = name;
    
    [CoreDataStack.sharedStack saveContext];
}

+ (void)removeFolder:(Folder *) folder {
    [CoreDataStack.sharedStack.managedObjectContext deleteObject:folder];
    [CoreDataStack.sharedStack saveContext];
}

+ (NSArray*)getFolders {
    NSArray* fetchedFolders = [[NSArray alloc] init];
    
    @try{
        NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Folder"];
        NSError *error;
        fetchedFolders = [CoreDataStack.sharedStack.managedObjectContext executeFetchRequest:request error:&error];
    }
    @catch (NSException * error) {
        
    }
    
    return fetchedFolders;
}

+ (NSNumber*)getPlannedTaskForDate:(NSDate*)date {
    NSArray* fetchedFolders = [[NSArray alloc] init];
    NSManagedObjectContext* context = CoreDataStack.sharedStack.managedObjectContext;
    
    @try{
        NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"CompletedFolder"];
        NSError *error;
        fetchedFolders = [context executeFetchRequest:request error:&error];
    }
    @catch (NSException * error) {
        
    }
    CompletedFolder *folder;
    
    if (fetchedFolders.count == 0) {
        NSEntityDescription* entity = [NSEntityDescription entityForName:@"CompletedFolder" inManagedObjectContext:context];
        folder = [[CompletedFolder alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    }
    else {
        folder = fetchedFolders[0];
    }
    
    NSUInteger count = 0;
    for(Task* task in folder.tasks) {
        NSLog(@"%@ %@",task.name , task.date.description);
        if ([self isSameDay:task.date otherDay:date]) {
            count += 1;
        }
    }
    return [NSNumber numberWithInt:count];
}

+ (BOOL)isSameDay:(NSDate*)date1 otherDay:(NSDate*)date2 {
    if ((date1 == nil) || (date2 == nil))
        return NO;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

@end
