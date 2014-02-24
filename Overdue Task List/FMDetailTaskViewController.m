//
//  FMDetailViewController.m
//  Overdue Task List
//
//  Created by Fredrick Myers on 2/20/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMDetailTaskViewController.h"
#import "FMEditTaskViewController.h"
#define TO_EDIT_TASK @"toEditTaskViewContoller"

@interface FMDetailViewController ()

@end

@implementation FMDetailViewController

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
    [self setupViewWithTask:self.taskObject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:TO_EDIT_TASK sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:TO_EDIT_TASK]) {
        FMEditTaskViewController *editTaskVC = segue.destinationViewController;
        editTaskVC.taskObject = self.taskObject;
        editTaskVC.delegate = self;
    }
    
}

#pragma mark - FMEditTaskViewController Delegates

- (void)didPressCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didEditTask:(FMTask *)task
{
    self.taskObject = task;
    [self setupViewWithTask:self.taskObject];
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate didUpdateTask:task atIndexPath:self.taskIndexPath];
    
}

#pragma mark - Helper Methods

- (void)setupViewWithTask:(FMTask *)task
{
    self.labelTaskName.text = task.title;
    self.labelTaskDescription.text = task.detail;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM d, yyyy"];
    NSString *dateToString = [formatter stringFromDate:task.date];
    self.labelTaskDate.text = dateToString;
}

@end
