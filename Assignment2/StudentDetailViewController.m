//
//  StudentDetailViewController.m
//  Assignment2
//
//  Created by david on 10/12/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import "StudentDetailViewController.h"

@interface StudentDetailViewController ()
// MARK: UI Properties
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLastName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCWID;
@property (weak, nonatomic) IBOutlet UILabel *labelError;

// MARK: Actions
- (IBAction)cancelStudentDetail:(id)sender;
- (IBAction)validateToSave:(UIButton *)sender;
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
        NSLog(@"Editing Student");
        // We got data for editing.  Update the view.
        self.textFieldFirstName.text = self.aStudent.firstName;
        self.textFieldLastName.text = self.aStudent.lastName;
        self.textFieldCWID.text = self.aStudent.CWID;
    }
    
    NSLog(@"Adding New Student");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

// MARK: TextField Delegation
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (sender == self.saveButton) {
        NSLog(@"Save Student Data.  Pass it back");
        
        // Retrieve data
        NSString *first = [self.textFieldFirstName.text capitalizedString];
        NSString *last = [self.textFieldLastName.text capitalizedString];
        NSString *cwid = self.textFieldCWID.text;
        
        // Create the student object
        self.aStudent = [Student newStudentFirstName:first lastName:last andCWID:cwid];
        
    }
}


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



@end
