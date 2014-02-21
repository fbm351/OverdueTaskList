//
//  FMViewController.m
//  Overdue Task List
//
//  Created by Fredrick Myers on 2/20/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMViewController.h"
#define TO_ADD_VIEW @"toAddedTaskViewController"

@interface FMViewController ()

@end

@implementation FMViewController

#pragma mark - Lazy Instantiation

- (NSMutableArray *)tasks
{
    if (!_tasks) {
        _tasks = [[NSMutableArray alloc] init];
    }
    return _tasks;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender
{
    
}

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:TO_ADD_VIEW sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:TO_ADD_VIEW])
    {
        FMAddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
}

#pragma mark - FMAddTaskViewController delegates

- (void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Did Cancel");
}

- (void)didAddTask:(FMTask *)task
{
    [self.tasks addObject:task];
    
    NSMutableArray *taskAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_LIST] mutableCopy];
    if (!taskAsPropertyLists) {
        taskAsPropertyLists = [[NSMutableArray alloc] init];
    }
    [taskAsPropertyLists addObject:[self taskAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskAsPropertyLists forKey:TASK_LIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
    
}

#pragma mark - Helper Methods

- (NSDictionary *)taskAsPropertyList:(FMTask *)task
{
    NSDictionary *dictionary = @{TASK_TITLE : task.title, TASK_DETAIL : task.detail, TASK_DATE : task.date, TASK_COMPLETE : @(task.completed)};
    return dictionary;
}

@end
