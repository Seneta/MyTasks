//
//  MTTask.h
//  MyTasks
//
//  Created by Seneta Yuriy on 26.09.16.
//  Copyright © 2016 Romanova Ksenia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MTPeriodicityType) {
    Daily = 0,
    Weekly = 1
};

typedef NS_ENUM(NSUInteger, MTStatusType) {
    Processed = 0,
    Done = 1,
    Deleted = 2
};

@interface MTTask : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptions;
@property (nonatomic, strong) NSDate *creatingDate;
@property (nonatomic, strong) NSDate *deadlineDate;
@property (nonatomic, strong) NSNumber *priority;
@property (assign, nonatomic) MTPeriodicityType periodicity;
@property (assign, nonatomic) MTStatusType status;

- (instancetype)initWithDictionary:(NSDictionary *)taskInfo;

@end
