//
//  SecondViewController.h
//  Assignment2
//
//  Created by david on 10/10/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
#import "StudentDetailViewController.h"

@interface StudentsViewController : UITableViewController

// MARK: Navigation
-(IBAction) unwindFromStudentDetail: (UIStoryboardSegue*) segue;

@end

