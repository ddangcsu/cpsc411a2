//
//  StudentDetailViewController.m
//  Assignment2
//
//  Created by david on 10/12/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import "StudentDetailViewController.h"
#import "CoursesViewController.h"

@interface StudentDetailViewController ()
// MARK: UI Properties
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLastName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCWID;
@property (weak, nonatomic) IBOutlet UILabel *labelError;
@property (weak, nonatomic) IBOutlet UITableView *enrolledCoursesView;

// This property is to temporary hold the enrollCourses while adding/editing
@property (strong, nonatomic) NSMutableArray<Course*> *enrolledCourses;

// MARK: UIActions
- (IBAction)cancelStudentDetail:(id)sender;
- (IBAction)validateToSave:(UIButton *)sender;

// MARK: Utilities
- (BOOL) validateDataInput;

@end

@implementation StudentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Disable the save button.  Turn it back on once the data are validated
    self.saveButton.enabled = NO;
    
    // Populate the data if it's an edit
    if (self.aStudent != nil) {
//        NSLog(@"Editing Student");
        self.navigationItem.title = @"Edit Student";
        // We got data for editing.  Update the view.
        self.textFieldFirstName.text = self.aStudent.firstName;
        self.textFieldLastName.text = self.aStudent.lastName;
        self.textFieldCWID.text = self.aStudent.CWID;
        
        self.enrolledCourses = self.aStudent.enrolledCourses;
        
//        for (Course* course in self.enrolledCourses) {
//            NSLog(@"Course Enrolled: %@", course.courseName);
//            NSLog(@"Course Weight: %@", course.getWeights);
//            NSLog(@"Course Scores: %@", course.getScores);
//        }
        
    } else {
        self.navigationItem.title = @"Add Student";
        self.enrolledCourses = [[NSMutableArray alloc]init];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: TextField Delegation
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// MARK: TableView Delegation
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Remove the data from model
        NSLog(@"Edit Style is Style Delete Row");
        [self.enrolledCourses removeObjectAtIndex:indexPath.row];
        
        // Refresh the view
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }

}

// MARK: TableView DataSource
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // We set the title for the enroll Course table view
    NSString *title = @"Enrolled Courses";
    return title;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of enrolled Courses
    return self.enrolledCourses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellId = @"enrolledCourseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    Course* course = self.enrolledCourses[indexPath.row];
    
    cell.textLabel.text = course.courseName;
    cell.detailTextLabel.text = [course getScores];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (sender == self.saveButton) {
        // NSLog(@"Save Student Data.  Pass it back");
        
        // Retrieve data
        NSString *first = [self.textFieldFirstName.text capitalizedString];
        NSString *last = [self.textFieldLastName.text capitalizedString];
        NSString *cwid = self.textFieldCWID.text;
        
        // Create the student object
        self.aStudent = [Student newStudentFirstName:first lastName:last andCWID:cwid];
        self.aStudent.enrolledCourses = self.enrolledCourses;
        
    } else if ([segue.identifier isEqualToString: @"enrollCourses"]) {
        // NSLog(@"We are trying to enroll courses");
        // Get the Course Listing View Controller
        CoursesViewController *courseListVC = [segue destinationViewController];
        
        // We pass the identifier so that CourseList view Controller can determine
        // whether to toggle edit mode with select only
        courseListVC.segueIdentifier = segue.identifier;
        
        // We also pass the current enrolled Courses so that the list will be filtered
        // and only display courses that we have not register yet.
        courseListVC.enrolledCourses = self.enrolledCourses;
    }
}

// Method when unwind from Selected Course List
-(void)unwindFromSelectedCourseList:(UIStoryboardSegue *)segue {
    // NSLog(@"Unwinded from Course List");
    
    // Get enrolled Courses from sourceVC
    CoursesViewController* enrolledVC = segue.sourceViewController;
    
    if (enrolledVC.enrolledCourses.count > 0) {
        // Add the selected courses to the temporary enrolled Courses array
        for (Course *course in enrolledVC.enrolledCourses) {
            // Get the current number of rows availables
            NSIndexPath *enrolledIndex = [NSIndexPath indexPathForRow:self.enrolledCourses.count inSection: 0];
            
            // Add data to the temporary enrolled Courses array
            [self.enrolledCourses addObject:course];
            
            // Tell the tableView to refresh data at the given index.
            [self.enrolledCoursesView insertRowsAtIndexPaths:@[enrolledIndex] withRowAnimation:UITableViewRowAnimationRight];
        }
    }
}

//MARK: Actions

- (IBAction)cancelStudentDetail:(id)sender {
    // Cancel to go back from Student Detail page
    UIViewController *presentFromVC = self.presentingViewController;
    
    NSLog(@"Student Detail: %@", [presentFromVC class]);
    if ([presentFromVC isKindOfClass:[UITabBarController class]]) {
        // We got navigated from UITabBarController (Add Student)
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        // It was a direct navigation from Student List To Edit
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (IBAction)validateToSave:(UIButton *)sender {
    // Validate the Input and turn on/off the save button
    self.saveButton.enabled = [self validateDataInput];
}

// MARK: Utilities
// Util Function to validate the data
-(BOOL) validateDataInput {
    // Hide keyboard
    [self.textFieldFirstName resignFirstResponder];
    [self.textFieldLastName resignFirstResponder];
    [self.textFieldCWID resignFirstResponder];
    
    // Retrieve data
    NSString *first = self.textFieldFirstName.text;
    NSString *last = self.textFieldLastName.text;
    NSString *cwid = self.textFieldCWID.text;
    
    if (first.length <= 0) {
        self.labelError.text = @"First Name is required";
        [self.textFieldFirstName becomeFirstResponder];
        return NO;
    }
    if (last.length <= 0) {
        self.labelError.text = @"Last Name is required";
        [self.textFieldLastName becomeFirstResponder];
        return NO;
    }
    if (cwid.length <= 0) {
        self.labelError.text = @"CWID is required";
        [self.textFieldCWID becomeFirstResponder];
        return NO;
    }
    
    // If we get here, it means it's good
    return YES;
}


@end
