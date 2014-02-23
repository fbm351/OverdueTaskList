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
    self.labelTaskName.text = self.taskObject.title;
    self.labelTaskDescription.text = self.taskObject.detail;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateToString = [formatter stringFromDate:self.taskObject.date];
    self.labelTaskDate.text = dateToString;
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
    }
    
}
@end
