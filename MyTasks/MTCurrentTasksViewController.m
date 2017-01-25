//
//  MTCurrentTasksViewController.m
//  MyTasks
//
//  Created by Seneta Yuriy on 09.09.16.
//  Copyright © 2016 Romanova Ksenia. All rights reserved.
//

#import "MTCurrentTasksViewController.h"
#import "MTHomeViewController.h"
#import "TaskCell.h"
#import "TasksHeaderCell.h"
#import "MTCurrentTasksViewController.h"
#import "MTCustomizeTaskViewController.h"
#import "MTTasksHolder.h"
#import "MTTask.h"

@interface MTCurrentTasksViewController ()<UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;

@end

@implementation MTCurrentTasksViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = self.folder.title;
    self.emptyLabel.hidden = !(self.folder.tasks.count == 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //self.emptyLabel.hidden = !([MTTasksHolder holder].folders.count == 0);
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:@"MTRefreshTasksNotification" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self.tableView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"TasksToCustomizeTaskSegue"]) {
        MTCustomizeTaskViewController *vc = segue.destinationViewController;
        vc.task = (MTTask *)sender;
    }
}

#pragma mark - TabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return viewController != tabBarController.selectedViewController;
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.folder.tasks.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 TasksHeaderCell *header = [tableView dequeueReusableCellWithIdentifier:@"TasksHeaderCell"];
 
 ////
 if(section == 0) {
 header.dateLabel.text = @"No date";
 }
 else {
 header.dateLabel.text = @"18.09, Friday";
 }
 
 return header;
 }
 
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
 return 60;
 }*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TasksHeaderCell"];
    
    MTTask *task = self.folder.tasks[indexPath.row];
    cell.titleLabel.text = task.title;
    cell.deadlineDateLabel.text = [task.deadlineDate description];
    
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"Remove" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor redColor]]];
    cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"Done" backgroundColor:[UIColor blueColor]]];
    [(UIButton *)cell.rightButtons[0] addTarget:self action:@selector(removeTask:) forControlEvents:UIControlEventTouchDown];
    
    cell.leftExpansion.buttonIndex = 0;
    //cell.leftExpansion.fillOnTrigger = YES;
    
    cell.rightExpansion.buttonIndex = 0;
    //cell.rightExpansion.fillOnTrigger = YES;
    return cell;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"TasksToCustomizeTaskSegue" sender:self.folder.tasks[indexPath.row]];
}

- (IBAction)pressNewTaskButton:(id)sender {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"New task"
                                          message:@"Enter name of new task"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = @"Name";
     }];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary *taskDict = @{@"title": alertController.textFields.lastObject.text};
        MTTask *newTask = [[MTTask alloc] initWithDictionary:taskDict];
        [self.folder addTask:newTask];
        self.emptyLabel.hidden = !(self.folder.tasks.count == 0);
        [self.tableView reloadData];
    }];
    
    [alertController addAction: OKAction];
    //OKAction.enabled = NO;
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)removeTask:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    [self.folder removeTask:(int)indexPath.row];
    self.emptyLabel.hidden = !(self.folder.tasks.count == 0);
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
