//
//  FMDetailViewController.h
//  Overdue Task List
//
//  Created by Fredrick Myers on 2/20/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTask.h"
#import "FMEditTaskViewController.h"

@protocol FMDetailViewControllerDelegate <NSObject>

@required

-(void)didUpdateTask:(FMTask *)task;

@end

@interface FMDetailViewController : UIViewController <FMEditTaskViewControllerDelegate>

//Properties
@property (weak, nonatomic) id <FMDetailViewControllerDelegate> delegate;
@property (strong, nonatomic) FMTask *taskObject;

//IBOutlets
@property (strong, nonatomic) IBOutlet UILabel *labelTaskName;
@property (strong, nonatomic) IBOutlet UILabel *labelTaskDescription;
@property (strong, nonatomic) IBOutlet UILabel *labelTaskDate;

//IBActions
- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;

@end
