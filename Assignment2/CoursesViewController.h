//
//  FirstViewController.h
//  Assignment2
//
//  Created by david on 10/10/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "CourseDetailViewController.h"

@interface CoursesViewController : UITableViewController

// MARK: Properties
@property (strong, nonatomic) NSString* segueIdentifier;
@property (strong, nonatomic) NSMutableArray<Course*> *enrolledCourses;

// MARK: Navigation
-(IBAction) unwindFromCourseDetail: (UIStoryboardSegue*) segue;

@end

