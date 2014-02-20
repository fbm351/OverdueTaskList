//
//  FMViewController.m
//  Overdue Task List
//
//  Created by Fredrick Myers on 2/20/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMViewController.h"

@interface FMViewController ()

@end

@implementation FMViewController

#pragma mark - Lazy Instantiation

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
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", self.tasks);
}

@end
