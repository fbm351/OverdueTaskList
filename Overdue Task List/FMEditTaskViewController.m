//
//  FMEditTaskViewController.m
//  Overdue Task List
//
//  Created by Fredrick Myers on 2/20/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMEditTaskViewController.h"

@interface FMEditTaskViewController ()

@end

@implementation FMEditTaskViewController

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
    
    self.textFieldTaskName.text = self.taskObject.title;
    self.textView.text = self.taskObject.detail;
    self.datePicker.date = self.taskObject.date;
    self.textView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender
{
    self.taskObject.title = self.textFieldTaskName.text;
    self.taskObject.detail = self.textView.text;
    self.taskObject.date = self.datePicker.date;
    
    [self.delegate didEditTask:self.taskObject];
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender
{
    [self.delegate didPressCancel];
}

#pragma mark - UITextView Delegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [self.textView resignFirstResponder];
        return NO;
    }
    
    else
    {
        return YES;
    }
}


@end
