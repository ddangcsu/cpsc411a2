//
//  CourseDetailViewController.m
//  Assignment2
//
//  Created by david on 10/11/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import "CourseDetailViewController.h"

@interface CourseDetailViewController ()

// MARK: IB Properties
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldHomework;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMidterm;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFinal;
@property (weak, nonatomic) IBOutlet UILabel *labelError;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

// MARK: Actions
- (IBAction)courseDetailCancel:(UIBarButtonItem *)sender;
- (IBAction)validateToSave:(UIButton *)sender;

@end

@implementation CourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.saveButton.enabled = NO;
    
    if (self.aCourse != nil) {
        // We got data for editing
        self.navigationItem.title = @"Edit Course";
        self.textFieldName.text = self.aCourse.courseName;
        self.textFieldHomework.text = [NSString stringWithFormat:@"%.2f", self.aCourse.hWeight];
        self.textFieldMidterm.text = [NSString stringWithFormat:@"%.2f", self.aCourse.mWeight];
        self.textFieldFinal.text = [NSString stringWithFormat:@"%.2f", self.aCourse.fWeight];
        
    } else {
        self.navigationItem.title = @"Add Course";
        // Set focus and open keyboard on the course name
        [self.textFieldName becomeFirstResponder];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: Support Functions
-(BOOL) validateDataInput {
    
    // Hide keyboards
    [self.textFieldName resignFirstResponder];
    [self.textFieldHomework resignFirstResponder];
    [self.textFieldMidterm resignFirstResponder];
    [self.textFieldFinal resignFirstResponder];
    
    // Retrieve name and weights
    NSString *name = self.textFieldName.text;
    float hWeight = (self.textFieldHomework.text != nil) ? [self.textFieldHomework.text floatValue]: 0;
    float mWeight = (self.textFieldMidterm.text != nil) ? [self.textFieldMidterm.text floatValue]: 0;
    float fWeight = (self.textFieldFinal.text != nil) ? [self.textFieldFinal.text floatValue]: 0;
    
    // Perform validations
    if (name.length <= 0) {
        self.labelError.text = @"Name is required";
        [self.textFieldName becomeFirstResponder];
        return NO;
    }
    if (hWeight < 0 || hWeight > 100) {
        self.labelError.text = @"Homework Weight valid range 0 - 100";
        [self.textFieldHomework becomeFirstResponder];
        [self.textFieldHomework setSelected:YES];
        return NO;
    }
    if (mWeight < 0 || mWeight > 100) {
        self.labelError.text = @"Midterm Weight valid range 0 - 100";
        [self.textFieldMidterm becomeFirstResponder];
        return NO;
    }
    if (fWeight < 0 || fWeight > 100) {
        self.labelError.text = @"Final Weight valid range 0 - 100";
        [self.textFieldFinal becomeFirstResponder];
        return NO;
    }
    if ( (hWeight + mWeight + fWeight) != 100) {
        self.labelError.text = @"Sum Weights must added up to 100";
        return NO;
    }
    
    // If we can get here it means we are good with validation
    self.labelError.text = nil;
    return YES;
}

// MARK: TextField Delegation
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	if (textField == self.textFieldHomework ||
        textField == self.textFieldMidterm ||
        textField == self.textFieldFinal) {
        // We add the Button button toolbar onto the keypad
        [Utilities addDoneButtonToKeyPad:textField inView:self.view];
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIBarButtonItem*)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (sender == self.saveButton) {
        NSString *name = [self.textFieldName.text uppercaseString];
        float hWeight = [self.textFieldHomework.text floatValue];
        float mWeight = [self.textFieldMidterm.text floatValue];
        float fWeight = [self.textFieldFinal.text floatValue];
        
        // Set the properties aCourse
        self.aCourse = [Course newCourse:name hWeight:hWeight mWeight:mWeight fWeight:fWeight];
    }
}


- (IBAction)courseDetailCancel:(UIBarButtonItem *)sender {
    // Get the View Controller that present this Course Detail Page
    UIViewController *presentFromVC = self.presentingViewController;
    
    NSLog(@"presentFromVC Class Name: %@\n", [presentFromVC class]);
    
    // Check to see where it comes from
    if ( [presentFromVC isKindOfClass: [UITabBarController class]] ) {
        // If come from Tab Bar Controller (Course List or Student List)
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else {
        // It was a direct navigation from Course To Edit
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)validateToSave:(UIButton *)sender {
    // Run validation and either enable or disable save Button
    self.saveButton.enabled = [self validateDataInput];
}

@end
