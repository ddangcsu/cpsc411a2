//
//  FirstViewController.m
//  Assignment2
//
//  Created by david on 10/10/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import "CoursesViewController.h"

@interface CoursesViewController ()

// MARK: Model
@property (strong, nonatomic) NSMutableArray<Course*> *courseList;

// MARK: UIProperties
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

// MARK: UIActions
-(void) createDemoCourseList;
-(void) enrollSelectedCourses;

@end

@implementation CoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSLog(@"We were invoked by segue %@", self.segueIdentifier);
    
    if ([self.segueIdentifier isEqualToString:@"enrollCourses"]) {
        // Prepare the view to show the course appropriately for enrolling
        
        // We removed the left bar button and add a custom enroll button
        UIBarButtonItem *enrollButton = [[UIBarButtonItem alloc]
                                         initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                         target:self action:@selector(enrollSelectedCourses)];
                                         
        self.navigationItem.rightBarButtonItem = enrollButton;
        self.navigationItem.leftBarButtonItem = nil;
        
        // We enable tableView in edit mode and allow multiple selections
        [self.tableView setAllowsMultipleSelectionDuringEditing:YES];
        [self.tableView setEditing:YES animated:YES];
        
    } else {
        // Enable Edit Button item
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }
    
    [self createDemoCourseList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) createDemoCourseList {
    
    if (self.courseList == nil) {
        self.courseList = [[NSMutableArray alloc]init];
    }
    
    // To initalize a few sample courses:
    Course *c1 = [Course newCourse:@"CPSC411" hWeight:20 mWeight:40 fWeight:40];
    Course *c2 = [Course newCourse:@"CPSC456" hWeight:35 mWeight:35 fWeight:30];
    Course *c3 = [Course newCourse:@"CPSC473" hWeight:90 mWeight:5 fWeight:5];
    
    [self.courseList addObject:c1];
    [self.courseList addObject:c2];
    [self.courseList addObject:c3];
    
}

-(void) enrollSelectedCourses {
    NSLog(@"Button enroll Selected Course");
    
}
                                         
// MARK: TableView Delegation
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell selected at row %ld", indexPath.row);
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell unselected at row %ld", indexPath.row);
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Accessory selected for row %ld", indexPath.row);
}

// MARK: TableView Data Sources

// Message to return the number of Sections to display in Table View
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // We will only have 1 section in our table view
    return 1;
}

// Message to return the number of Rows to display in the section
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of courses
    return self.courseList.count;
}

// Message to return the tableView cell data at the given indexPath
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get the cell information
    NSString *cellId = @"courseTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    // Pull the course from courseList at the indexPath row
    Course *aCourse = self.courseList[indexPath.row];
    
    // Update the cell in the tableView
    cell.textLabel.text = aCourse.courseName;
    cell.detailTextLabel.text = aCourse.getWeights;
    

    
    // Return the cell object
    return cell;
}

// Allowing to Edit Row at a given index
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Message to determine what to do for the given editingStyle (Delete, Select, Insert)
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // User select Edit and choose Delete on a cell
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Remove the data from model
        NSLog(@"Edit Style is Style Delete Row");
        [self.courseList removeObjectAtIndex:indexPath.row];
        
        // Refresh the view
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// MARK: Navigation

//-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
//    // When the accessoryButton is tapped, trigger the segue editCourse
//    NSString *segueId = @"editCourse";
//    UITableViewCell *actionCell = [tableView cellForRowAtIndexPath:indexPath];
//    
//    [self performSegueWithIdentifier:segueId sender: actionCell];
//}

// Use the method below to allow to unwind data back from Course Detail View
-(IBAction) unwindFromCourseDetail: (UIStoryboardSegue*) segue {

    NSLog(@"UnwindFromCourseDetail:  segue id is %@", segue.identifier);
    
    // Get the View Controller where the data is unwind from
    CourseDetailViewController* detailVC = segue.sourceViewController;
    
    // Retrieve a course from detailVC
    Course *returnCourse = detailVC.aCourse;
    
    // Check to see if it was edit or add
    // NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
    
    // If we have data set
    if (returnCourse) {
        if (self.selectedIndexPath) {
            // We get data from Editing existing course at specific row
            NSLog(@"We are updating an existing course");
            
            // We replace the course data at specified row with the data received
            self.courseList[self.selectedIndexPath.row] = returnCourse;
            
            // Tell tableView to refresh it
            [self.tableView reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationRight];
            
        } else {
            // We get data from Adding a new row
            NSLog(@"We are adding a new course");
            // Get the tableView index path
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.courseList.count inSection:0];
            
            // Add data to array
            [self.courseList addObject:returnCourse];
            
            // Then we tell the tableView to update its view
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
    } else {
        NSLog(@"Unable to retrieve data from detail course");
    }
}

// Message to prepare the segue for a given sender before navigate off the current
// view controller
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"prepareForSegue: segue id is %@", segue.identifier);
    NSLog(@"Sender is of type: %@", [sender class]);
    
    // We want to see which segue was used to navigate
    if ([segue.identifier isEqualToString:@"addCourse"]) {
        // The user hit the add button
        NSLog(@"We want to add a new course");
        self.selectedIndexPath = nil;
        
    } else if ([segue.identifier isEqualToString:@"editCourse"]) {
        NSLog(@"We want to edit an existing course");
        // We use this to pass data forward to the CourseDetailViewController
        CourseDetailViewController *destinationVC = segue.destinationViewController;
        
        // We need to detect which row in the tableView was clicked so that we can
        // pass the correct data
        self.selectedIndexPath = [self.tableView indexPathForCell:sender];
        
        // We pass data to detailVC
        destinationVC.aCourse = self.courseList[self.selectedIndexPath.row];
    }
}


@end
