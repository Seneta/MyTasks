//
//  FolderCell.h
//  MyTasks
//
//  Created by Seneta Yurii on 1/19/17.
//  Copyright © 2017 Romanova Ksenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@interface FolderCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
