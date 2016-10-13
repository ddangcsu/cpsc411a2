//
//  StudentDetailViewController.h
//  Assignment2
//
//  Created by david on 10/12/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"

@interface StudentDetailViewController : UIViewController <UITextFieldDelegate>

// MARK: Properties to pass data back and forth
@property (strong, nonatomic) Student *aStudent;

@end
