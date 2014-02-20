//
//  FMAddTaskViewController.m
//  Overdue Task List
//
//  Created by Fredrick Myers on 2/20/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMAddTaskViewController.h"

@interface FMAddTaskViewController ()

@end

@implementation FMAddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTaskButtonPressed:(UIButton *)sender
{
    FMTask *addNewTask = [self ceateNewTask];
    [self.delegate didAddTask:addNewTask];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.delegate didCancel];
}

#pragma mark - Helper Methods


//This helper methods takes the input from the IBOulets on the view and creates a new Task object
- (FMTask *)ceateNewTask
{
    FMTask *newTask = [[FMTask alloc] init];
    newTask.title = self.textFieldTaskName.text;
    newTask.detail = self.textView.text;
    newTask.date = self.datePicker.date;
    newTask.completed = NO;
    return newTask;
}

@end
