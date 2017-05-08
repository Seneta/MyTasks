//
//  MTStaticticsViewController.m
//  MyTasks
//
//  Created by Yurii Seneta on 5/7/17.
//  Copyright © 2017 Romanova Ksenia. All rights reserved.
//

#import "MTStaticticsViewController.h"
#import "JYGraphView.h"
#import "DataManager.h"

@interface MTStaticticsViewController ()
@property (strong, nonatomic) JYGraphView *graphView;


@end

@implementation MTStaticticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.graphView = [[JYGraphView alloc] initWithFrame:self.view.frame];
    self.graphView.graphWidth = self.view.frame.size.width;
    [self.view addSubview:self.graphView];
    [self setUpGraph:-7];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.graphView removeFromSuperview];
    [self.view addSubview:self.graphView];
    [self setUpGraph:-7];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpGraph:(NSInteger)daysToAdd {
    // Start with some date, e.g. now:
    NSDate *now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    // set up date components
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:daysToAdd];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateByAddingComponents:components toDate:now options:0];
    
    // Some output format (adjust to your needs):
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"dd.MM"];
    
    // Repeatedly add one day:
    NSDateComponents *comp2 = [[NSDateComponents alloc] init];
    [comp2 setDay:1];
    
    NSMutableArray *dates = [NSMutableArray array];
    NSMutableArray *tasksNumber = [NSMutableArray array];
    
    for (int i = 1; i <= abs(daysToAdd); i++) {
        NSString *text = [fmt stringFromDate:date];
        [dates addObject:text];
        [tasksNumber addObject:[DataManager getPlannedTaskForDate:date]];
        date = [cal dateByAddingComponents:comp2 toDate:date options:0];
    }
    self.graphView.graphDataLabels = dates;
    self.graphView.graphData = tasksNumber;
    [self.graphView plotGraphData];
}


#pragma mark - Navigation

 - (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
     return 4; // Number of points in the graph.
 }

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return index; // The value of the point on the Y-Axis for the index.
}



@end
