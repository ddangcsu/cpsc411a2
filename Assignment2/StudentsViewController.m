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
@end

@implementation StudentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self getDemoStudents];
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
}

// MARK: UITableView Data Source
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the entry from Model
        [self.studentList removeObjectAtIndex:indexPath.row];
        
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
    cell.textLabel.text = student.fullName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"CWID: %@", student.CWID];
    
    // Return the cell to Table View to display
    return cell;
}

// MARK: Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"addStudent"]) {
        NSLog(@"We are about to add a new student");
        
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
            NSLog(@"We are updating an existing student");
            
            // We replace the course data at specified row with the data received
            self.studentList[selectedIndexPath.row] = aStudent;
            
            // Tell tableView to refresh it
            [self.tableView reloadRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationRight];
            
        } else {
            // We get data from Adding a new row
            NSLog(@"We are adding a new student");
            // Get the tableView index path
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.studentList.count inSection:0];
            
            // Add data to array
            [self.studentList addObject:aStudent];
            
            // Then we tell the tableView to update its view
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
    } else {
        NSLog(@"Unable to retrieve data from detail student");
    }
}


@end
