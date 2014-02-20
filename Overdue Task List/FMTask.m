//
//  FMTask.m
//  Overdue Task List
//
//  Created by Fredrick Myers on 2/20/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMTask.h"

@implementation FMTask

-(id)init
{
    self = [self initWithData:nil];
    return self;
}

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    self.title = data[TASK_TITLE];
    self.detail = data[TASK_DETAIL];
    self.date = data[TASK_DATE];
    self.completed = [data[TASK_COMPLETE] boolValue];
    
    return self;
}

@end
