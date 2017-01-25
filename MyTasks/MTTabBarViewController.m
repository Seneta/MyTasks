//
//  MTTabBarViewController.m
//  MyTasks
//
//  Created by Seneta Yuriy on 07.09.16.
//  Copyright © 2016 Romanova Ksenia. All rights reserved.
//

#import "MTTabBarViewController.h"
#import <Foundation/Foundation.h>
#import "MTCurrentTasksViewController.h"
#import "MTHomeViewController.h"

@interface MTTabBarViewController ()

@end

@implementation MTTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    if (item.tag == 0) {
//        UINavigationController *navigationVC = [self.viewControllers objectAtIndex:0];
//        if ([navigationVC.topViewController isKindOfClass:[MTHomeViewController class]]) {
//            MTCurrentTasksViewController *VCToShow = (MTCurrentTasksViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"MTCurrentTasksViewController"];
//            [navigationVC pushViewController:VCToShow animated:YES];
//        }
//    }
}

@end
