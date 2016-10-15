//
//  CourseDetailViewController.h
//  Assignment2
//
//  Created by david on 10/11/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "Utilities.h"

@interface CourseDetailViewController : UIViewController <UITextFieldDelegate>
// MARK: Properties to pass data back and forth
@property (strong, nonatomic) Course* aCourse;

@end
