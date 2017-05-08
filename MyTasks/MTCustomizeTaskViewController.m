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

@end

@implementation MTCustomizeTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //for hiding keyboard
    [self.titleTextField setReturnKeyType:UIReturnKeyDone];
    [self.descriptionsTextView setReturnKeyType:UIReturnKeyDone];
    
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

- (IBAction)pressedCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pressedDoneButton:(id)sender {
    self.task.name = self.titleTextField.text;
    self.task.descriptions = self.descriptionsTextView.text;
    self.task.date = self.datePicker.date;
    NSLog(@"%u", self.task.priority);
    [self.task setPriority:[NSNumber numberWithInt:1]];// = INT32_C(1);
    
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
