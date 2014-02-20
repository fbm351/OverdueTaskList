//
//  FMAddTaskViewController.h
//  Overdue Task List
//
//  Created by Fredrick Myers on 2/20/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMAddTaskViewController : UIViewController

//IBOutlets
@property (strong, nonatomic) IBOutlet UITextField *textFieldTaskName;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

//IBActions
- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
