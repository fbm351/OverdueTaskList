//
//  FMEditTaskViewController.h
//  Overdue Task List
//
//  Created by Fredrick Myers on 2/20/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTask.h"


@protocol FMEditTaskViewControllerDelegate <NSObject>

@required

- (void)didPressCancel;
- (void)didEditTask;

@end

@interface FMEditTaskViewController : UIViewController <UITextViewDelegate>

//Properties
@property (weak, nonatomic) id <FMEditTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) FMTask *taskObject;

//IBOutlets
@property (strong, nonatomic) IBOutlet UITextField *textFieldTaskName;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

//IBActions
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;

@end
