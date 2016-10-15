//
//  CourseScoreViewController.m
//  Assignment2
//
//  Created by david on 10/14/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import "CourseScoreViewController.h"

@interface CourseScoreViewController ()
// MARK: UI Properties
@property (weak, nonatomic) IBOutlet UILabel *labelError;
@property (weak, nonatomic) IBOutlet UITextField *tfHomeWork;
@property (weak, nonatomic) IBOutlet UITextField *tfMidterm;
@property (weak, nonatomic) IBOutlet UITextField *tfFinal;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

// MARK: UI Actions
- (IBAction)validateDataInput:(UIButton *)sender;

// MARK: Utilities
- (BOOL) performValidation;

@end

@implementation CourseScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.aCourse != nil) {
        // We populate the view with the Model data passed to us
        self.navigationItem.title = [NSString stringWithFormat:@"%@ score", self.aCourse.courseName];
        self.tfHomeWork.text = [NSString stringWithFormat:@"%.2f", self.aCourse.hScore];
        self.tfMidterm.text = [NSString stringWithFormat:@"%.2f", self.aCourse.mScore];
        self.tfFinal.text = [NSString stringWithFormat:@"%.2f", self.aCourse.fScore];
        
        // We disable the Save button to begin with
        self.saveButton.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: TextField Delegation
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // Since all fields are numeric field, we just turn on the Done button
    [Utilities addDoneButtonToKeyPad:textField inView:self.view];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ( sender == self.saveButton ) {
        float hScore = [self.tfHomeWork.text floatValue];
        float mScore = [self.tfMidterm.text floatValue];
        float fScore = [self.tfFinal.text floatValue];
		// Update the score
        [self.aCourse setHomeworkScore:hScore midtermScore:mScore finalScore:fScore];
    }
}

- (IBAction)validateDataInput:(UIButton *)sender {
    self.saveButton.enabled = [self performValidation];
}

// MARK: Utilities
- (BOOL) performValidation {
    // Close the keyboard
    [self.tfHomeWork resignFirstResponder];
    [self.tfMidterm resignFirstResponder];
    [self.tfFinal resignFirstResponder];
    self.labelError.text = nil;
    
    float hScore = [self.tfHomeWork.text floatValue];
    float mScore = [self.tfMidterm.text floatValue];
    float fScore = [self.tfFinal.text floatValue];
    
    if (hScore > 100) {
        self.labelError.text = @"Average homework cannot exceed 100";
        [self.tfHomeWork becomeFirstResponder];
        return NO;
    }
    if (mScore > 100) {
        self.labelError.text = @"Midterm cannot exceed 100";
        [self.tfMidterm becomeFirstResponder];
        return NO;
    }
    if (fScore > 100) {
        self.labelError.text = @"Final cannot exceed 100";
        [self.tfFinal becomeFirstResponder];
        return NO;
    }
    return YES;
}

@end
