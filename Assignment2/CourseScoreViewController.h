//
//  CourseScoreViewController.h
//  Assignment2
//
//  Created by david on 10/14/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "Utilities.h"

@interface CourseScoreViewController : UIViewController <UITextFieldDelegate>
// MARK: Properties to pass between VC
@property (strong, nonatomic) Course *aCourse;

@end
