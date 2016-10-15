//
//  SecondViewController.m
//  Assignment2
//
//  Created by david on 10/10/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import "StudentsViewController.h"

@interface StudentsViewController ()
@property (nonatomic, strong) NSMutableArray<Student*> *studentList;

// MARK: Archiving methods
-(BOOL) archivedStudentLists;
-(NSMutableArray<Student*>*) loadStudentLists;

@end

@implementation StudentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    if (self.studentList == nil) {
        self.studentList = [self loadStudentLists];
    }
    
    if (self.studentList == nil) {
	    [self getDemoStudents];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getDemoStudents {
    // Method to temporary return some sample student
    if (self.studentList == nil) {
        self.studentList = [[NSMutableArray alloc] initWithCapacity:3];
    }
    
    Student *s1 = [Student newStudentFirstName:@"David" lastName:@"Dang" andCWID: @"123456789"];
    Student *s2 = [Student newStudentFirstName:@"Tom" lastName:@"Kyle" andCWID: @"483929102"];
    Student *s3 = [Student newStudentFirstName:@"Austin" lastName:@"Williams" andCWID: @"483101828"];
    
    [self.studentList addObject:s1];
    [self.studentList addObject:s2];
    [self.studentList addObject:s3];
    
    Course *c1 = [Course newCourse:@"CPSC411" hWeight:20 mWeight:40 fWeight:40];
    Course *c2 = [Course newCourse:@"CPSC456" hWeight:35 mWeight:35 fWeight:30];
    
    // Add some course
    [s1.enrolledCourses addObject: c1];
    [s1.enrolledCourses addObject: c2];
    
    [s2.enrolledCourses addObject: c2];
    [s3.enrolledCourses addObject: c1];
}

// MARK: Archiving methods

/* Function to save the student lists to file */
-(BOOL) archivedStudentLists {
    BOOL isArchived = NO;
    NSString *path = [Student getArchivePath].path;
    isArchived = [NSKeyedArchiver archiveRootObject:self.studentList toFile:path];
    
    if (! isArchived ) {
        NSLog(@"Unable to save Student Lists");
        return NO;
    }
    return YES;
}

/* Function to return the list of student from file */
-(NSMutableArray<Student*>*) loadStudentLists {
    NSString *path = [Student getArchivePath].path;
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

// MARK: UITableView Data Source
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the entry from Model
        [self.studentList removeObjectAtIndex:indexPath.row];
        
        // Archive it
        if (! [self archivedStudentLists]) {
            NSLog(@"Something went wrong with archive student list");
        }
        
        // Refresh view
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // We will only have 1 section per table view
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows from model
    return self.studentList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"studentTableCell";
    
    // Get the instance of the cell at the indexPath
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    // Pull the data from Model
    Student *student = self.studentList[indexPath.row];
    
    // Assign data from Model
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - Courses: %lu", student.fullName, student.enrolledCourses.count];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"CWID: %@", student.CWID];
    
    // Return the cell to Table View to display
    return cell;
}

// MARK: Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"addStudent"]) {
        // NSLog(@"We are about to add a new student");
        
    } else if ([segue.identifier isEqualToString:@"editStudent"]) {
        // Get the destination view controller
        StudentDetailViewController *destinationVC = segue.destinationViewController;
        
        // Get the index of the cell that we selected
        NSIndexPath *selectedPath = [self.tableView indexPathForCell:sender];
        
        // Update the model data on the destination View Controller
        destinationVC.aStudent = self.studentList[selectedPath.row];
        
    }
}

-(IBAction) unwindFromStudentDetail: (UIStoryboardSegue*) segue {
    
    // Get the View Controller where the data is unwind from
    StudentDetailViewController* detailVC = segue.sourceViewController;
    
    // Retrieve a course from detailVC
    Student *aStudent = detailVC.aStudent;
    
    // Check to see if it was edit or add
    NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
    
    // If we have data set
    if (aStudent) {
        if (selectedIndexPath) {
            // We get data from Editing existing course at specific row
            //NSLog(@"We are updating an existing student");
            
            // We replace the course data at specified row with the data received
            self.studentList[selectedIndexPath.row] = aStudent;
            
            // Tell tableView to refresh it
            [self.tableView reloadRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationRight];
            
        } else {
            // We get data from Adding a new row
            //NSLog(@"We are adding a new student");
            // Get the tableView index path
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.studentList.count inSection:0];
            
            // Add data to array
            [self.studentList addObject:aStudent];
            
            // Then we tell the tableView to update its view
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
        // Archive it
        if (! [self archivedStudentLists]) {
            NSLog(@"Something went wrong with archive student list");
        }
        
    } else {
        NSLog(@"Unable to retrieve data from detail student");
    }
}


@end
