//
//  MTCustomizeTaskViewController.h
//  MyTasks
//
//  Created by Seneta Yuriy on 09.09.16.
//  Copyright © 2016 Romanova Ksenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTTask.h"
#import "DataManager.h"
#import "CoreDataStack.h"

@interface MTCustomizeTaskViewController : UIViewController

@property (strong, nonatomic) Task *task;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionsTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UIButton *firstPriorityButton;
@property (weak, nonatomic) IBOutlet UIButton *secondPriorityButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdPriorityButton;

@end
