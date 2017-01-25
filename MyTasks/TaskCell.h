//
//  TaskCell.h
//  MyTasks
//
//  Created by Seneta Yuriy on 19.07.16.
//  Copyright © 2016 Romanova Ksenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@interface TaskCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *priorityImageView;
@property (weak, nonatomic) IBOutlet UILabel *deadlineDateLabel;

@end
