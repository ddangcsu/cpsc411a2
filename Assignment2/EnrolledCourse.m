//
//  EnrolledCourse.m
//  Assignment2
//
//  Created by david on 10/13/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import "EnrolledCourse.h"

@implementation EnrolledCourse

-(void) setHomeworkScore: (float) hScore midtermScore: (float) mScore finalScore: (float) fScore {
    self.hScore = hScore;
    self.mScore = mScore;
    self.fScore = fScore;
}

-(NSString*) getScores {
    NSString *output = [NSString stringWithFormat:@"Homework: %.2f Midterm: %.2f Final: %.2f",
                        self.hScore, self.mScore, self.fScore];
    return output;
}


@end
