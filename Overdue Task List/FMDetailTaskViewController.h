//
//  FMDetailViewController.h
//  Overdue Task List
//
//  Created by Fredrick Myers on 2/20/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTask.h"

@interface FMDetailViewController : UIViewController

//Properties
@property (strong, nonatomic) FMTask *taskObject;

//IBOutlets
@property (strong, nonatomic) IBOutlet UILabel *labelTaskName;
@property (strong, nonatomic) IBOutlet UILabel *labelTaskDescription;
@property (strong, nonatomic) IBOutlet UILabel *labelTaskDate;

//IBActions
- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;

@end
