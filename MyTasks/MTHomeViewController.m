//
//  MTHomeViewController.m
//  MyTasks
//
//  Created by Seneta Yuriy on 19.07.16.
//  Copyright © 2016 Romanova Ksenia. All rights reserved.
//

#import "MTHomeViewController.h"
#import "TaskCell.h"
#import "TasksHeaderCell.h"
#import "MTCurrentTasksViewController.h"
#import "MTCustomizeTaskViewController.h"
#import "MTTasksHolder.h"
#import "FolderCell.h"
#import "MTFolder.h"
#import "MTTask.h"

@interface MTHomeViewController ()<UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;

@end

@implementation MTHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.emptyLabel.hidden = !([MTTasksHolder holder].folders.count == 0);
    [self.homeTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.delegate = self;
    self.homeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.emptyLabel.hidden = !([MTTasksHolder holder].folders.count == 0);
    [[NSNotificationCenter defaultCenter] addObserver:self.homeTableView selector:@selector(reloadData) name:@"MTRefreshTasksNotification" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self.homeTableView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"FoldersToTasksSegue"]) {
        MTCurrentTasksViewController *vc = segue.destinationViewController;
        vc.folder = (MTFolder *)sender;
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
    return [MTTasksHolder holder].folders.count;
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
    FolderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FolderCell"];
    
    MTFolder *folder = [MTTasksHolder holder].folders[indexPath.row];
    cell.titleLabel.text = folder.title;
    cell.countLabel.text = [NSString stringWithFormat:@"%lu tasks", (unsigned long)folder.tasks.count];

    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"Remove" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor redColor]]];
    [(UIButton *)cell.rightButtons[0] addTarget:self action:@selector(removeFolder:) forControlEvents:UIControlEventTouchDown];
    
    cell.leftExpansion.buttonIndex = 0;
    //cell.leftExpansion.fillOnTrigger = YES;
    
    return cell;
    
    return cell;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"FoldersToTasksSegue" sender:[MTTasksHolder holder].folders[indexPath.row]];
}

- (IBAction)pressNewTaskButton:(id)sender {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"New folder"
                                          message:@"Enter name of new folder"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = @"Name";
     }];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[MTTasksHolder holder] addNewFolder:alertController.textFields.lastObject.text];
        self.emptyLabel.hidden = !([MTTasksHolder holder].folders.count == 0);
        [self.homeTableView reloadData];
    }];
    
    [alertController addAction: OKAction];
    //OKAction.enabled = NO;
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)removeFolder:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.homeTableView];
    NSIndexPath *indexPath = [self.homeTableView indexPathForRowAtPoint:buttonPosition];
    
    [[MTTasksHolder holder] removeFolder:(int)indexPath.row];
    [self.homeTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    self.emptyLabel.hidden = !([MTTasksHolder holder].folders.count == 0);
}

@end
