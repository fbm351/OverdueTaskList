//
//  FMTask.h
//  Overdue Task List
//
//  Created by Fredrick Myers on 2/20/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMTask : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL completed;

- (id)initWithData:(NSDictionary *)data;

@end
