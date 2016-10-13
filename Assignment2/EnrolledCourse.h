//
//  EnrolledCourse.h
//  Assignment2
//
//  Created by david on 10/13/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"

@interface EnrolledCourse : Course
@property (assign, nonatomic) float hScore;
@property (assign, nonatomic) float mScore;
@property (assign, nonatomic) float fScore;

-(void) setHomeworkScore: (float) hScore midtermScore: (float) mScore finalScore: (float) fScore;

-(NSString*) getScores;

@end
