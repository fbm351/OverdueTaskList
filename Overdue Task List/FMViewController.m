//
//  FMViewController.m
//  Overdue Task List
//
//  Created by Fredrick Myers on 2/20/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMViewController.h"
#define TO_ADD_VIEW @"toAddedTaskViewController"
#define TO_DETAIL_VIEW @"toDetailTaskViewController"

@interface FMViewController ()

@end

@implementation FMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSArray *myTasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_LIST];
    for (NSDictionary *dictionary in myTasksAsPropertyLists)
    {
        FMTask *taskObject = [self taskObjectForDictionary:dictionary];
        [self.taskObjects addObject:taskObject];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender
{
    if (self.tableView.editing == NO)
    {
        [self.tableView setEditing:YES animated:YES];
    }
    else
    {
        [self.tableView setEditing:NO animated:YES];
    }
}

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:TO_ADD_VIEW sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:TO_ADD_VIEW])
    {
        FMAddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:TO_DETAIL_VIEW])
    {
        FMDetailViewController *taskDetailVC = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        taskDetailVC.taskObject = self.taskObjects[indexPath.row];
        taskDetailVC.taskIndexPath = indexPath;
        taskDetailVC.delegate = self;
    }
}

#pragma mark - Lazy Instantiation

- (NSMutableArray *)taskObjects
{
    if (!_taskObjects)
    {
        _taskObjects = [[NSMutableArray alloc] init];
    }
    return _taskObjects;
}

#pragma mark - FMAddTaskViewController delegates

- (void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didAddTask:(FMTask *)task
{
    [self.taskObjects addObject:task];
    
    NSMutableArray *taskAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_LIST] mutableCopy];
    if (!taskAsPropertyLists) {
        taskAsPropertyLists = [[NSMutableArray alloc] init];
    }
    [taskAsPropertyLists addObject:[self taskObjectAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskAsPropertyLists forKey:TASK_LIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

#pragma mark - Helper Methods

//Takes a task object and converts it to a Dictionary of property lists
- (NSDictionary *)taskObjectAsPropertyList:(FMTask *)task
{
    NSDictionary *dictionary = @{TASK_TITLE : task.title, TASK_DETAIL : task.detail, TASK_DATE : task.date, TASK_COMPLETE : @(task.completed)};
    return dictionary;
}

//Takes a property list dictionary and converts it to a Task object.
- (FMTask *)taskObjectForDictionary:(NSDictionary *)dictionary
{
    FMTask *taskObject = [[FMTask alloc] initWithData:dictionary];
    return taskObject;
}

//Checks to see it a date is greater than another date
- (BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    if ([date timeIntervalSince1970] > [toDate timeIntervalSince1970]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

//This method grabs the list of tasks, removes the task at a specfic index, updates the task, restores the task to NSUserDefaults at the same index and then reloads the tableView
- (void)updateCompletionStatusOfTask:(FMTask *)task forIndex:(NSIndexPath *)indexPath
{
    NSMutableArray *taskObjectAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_LIST] mutableCopy];
    if (!taskObjectAsPropertyLists) {
        taskObjectAsPropertyLists = [[NSMutableArray alloc] init];
    }
    [taskObjectAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    if (task.completed) {
        task.completed = NO;
    }
    else
    {
        task.completed = YES;
    }
    [taskObjectAsPropertyLists insertObject:[self taskObjectAsPropertyList:task] atIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectAsPropertyLists forKey:TASK_LIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
    
}

//This methods takes the current tasks in taskObjects and creates a mutable array to and stores them in it and then changes them to a property list to pass back to NSUserDefaults.
- (void)saveTasks
{
    NSMutableArray *tasksAsPropertyLists = [[NSMutableArray alloc] init];
    for (int x = 0; x < [self.taskObjects count]; x ++) {
        [tasksAsPropertyLists addObject:[self taskObjectAsPropertyList:self.taskObjects[x]]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_LIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.taskObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TaskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    FMTask *task = [self.taskObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = task.title;
    
    //Convert date to string here
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM d, yyyy"];
    NSString *dateToString = [formatter stringFromDate:task.date];
    
    cell.detailTextLabel.text = dateToString;
    
    //Checks to see if the date on the task is older than today and sets it to red it the completed flag is NO
    if ([self isDateGreaterThanDate:[NSDate date] and:task.date] && !task.completed)
    {
        cell.backgroundColor = [UIColor redColor];
    }
    
    //Checks to see if the task is completed and
    else if (task.completed)
    {
        cell.backgroundColor = [UIColor greenColor];
    }
    
    //If the task is still open and not completed changes color to yellow
    else
    {
        cell.backgroundColor = [UIColor yellowColor];
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMTask *selectedTask = [self.taskObjects objectAtIndex:indexPath.row];
    [self updateCompletionStatusOfTask:selectedTask forIndex:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        [self saveTasks];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:TO_DETAIL_VIEW sender:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    FMTask *selectedTask = self.taskObjects[sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:selectedTask atIndex:destinationIndexPath.row];
    [self saveTasks];
}

#pragma mark - FMDetailTaskView Delegate

- (void)didUpdateTask
{
    [self saveTasks];
    [self.tableView reloadData];
    
}


@end
