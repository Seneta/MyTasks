//
//  MTCustomizeTaskViewController.m
//  MyTasks
//
//  Created by Seneta Yuriy on 09.09.16.
//  Copyright © 2016 Romanova Ksenia. All rights reserved.
//

#import "MTCustomizeTaskViewController.h"
#import "MTTasksHolder.h"

@interface MTCustomizeTaskViewController ()<UITextViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *priorityButtons;

@end

@implementation MTCustomizeTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //for hiding keyboard
    [self.titleTextField setReturnKeyType:UIReturnKeyDone];
    [self.descriptionsTextView setReturnKeyType:UIReturnKeyDone];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    [self.datePicker setLocale:locale];
    self.datePicker.layer.cornerRadius = 4;
    self.datePicker.layer.borderWidth = 0.5;
    self.datePicker.layer.borderColor = [[UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1] CGColor];
    self.descriptionsTextView.layer.borderColor = [[UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1] CGColor];
    self.descriptionsTextView.layer.borderWidth = 0.5f;
    self.descriptionsTextView.layer.cornerRadius = 4;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.titleTextField.text = self.task.name;
    self.descriptionsTextView.text = self.task.descriptions;
    [self.datePicker setDate:self.task.date ? self.task.date: [NSDate date]];
    
    for(UIButton* button in self.priorityButtons) {
        if(self.task.priority.intValue == button.tag) {
            [button setSelected:YES];
            button.alpha = 1;
        }
        else {
            [button setSelected:NO];
            button.alpha = 0.3;
        }
    }
}

#pragma mark Methods

-(void)dismissKeyboard {
    [self.descriptionsTextView resignFirstResponder];
    [self.titleTextField resignFirstResponder];
}

#pragma mark TextView Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark IBActions

- (IBAction)pressPriorityButton:(UIButton*)sender {
    for(UIButton* button in self.priorityButtons) {
        [button setSelected:NO];
        button.alpha = 0.3;
    }
    
    [sender setSelected:YES];
    sender.alpha = 1;
}


- (IBAction)pressedCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pressedDoneButton:(id)sender {
    self.task.name = self.titleTextField.text;
    self.task.descriptions = self.descriptionsTextView.text;
    self.task.date = self.datePicker.date;
    
    for(UIButton* button in self.priorityButtons) {
        if ([button isSelected]) {
            [self.task setPriority:[NSNumber numberWithInt:button.tag]];
            break;
        }
    }
    
    [CoreDataStack.sharedStack saveContext];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MTRefreshTasksNotification" object:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
