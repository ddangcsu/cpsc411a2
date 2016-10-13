//
//  FirstViewController.h
//  Assignment2
//
//  Created by david on 10/10/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoursesViewController : UITableViewController

// MARK: Navigation
-(IBAction) unwindFromCourseDetail: (UIStoryboardSegue*) segue;

@end

