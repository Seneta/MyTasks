//
//  TasksHeaderCell.h
//  MyTasks
//
//  Created by Seneta Yuriy on 09.09.16.
//  Copyright © 2016 Romanova Ksenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@interface TasksHeaderCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
