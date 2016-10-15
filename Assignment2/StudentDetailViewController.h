//
//  StudentDetailViewController.h
//  Assignment2
//
//  Created by david on 10/12/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
#import "Utilities.h"

@interface StudentDetailViewController : UIViewController
<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

// MARK: Properties to pass data back and forth
@property (strong, nonatomic) Student *aStudent;

// MARK: Unwind segue for enroll courses
-(IBAction) unwindFromSelectedCourseList: (UIStoryboardSegue*) segue;
-(IBAction) unwindFromCourseScore: (UIStoryboardSegue*) segue;

@end
