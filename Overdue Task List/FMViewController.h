//
//  FMViewController.h
//  Overdue Task List
//
//  Created by Fredrick Myers on 2/20/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMAddTaskViewController.h"

@interface FMViewController : UIViewController <FMAddTaskViewControllerDelegate>

//Objects
@property (strong, nonatomic) NSMutableArray *tasks;

//IBOutlets
@property (strong, nonatomic) IBOutlet UITableView *tableView;

//IBActions
- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)addButtonPressed:(UIBarButtonItem *)sender;

@end
