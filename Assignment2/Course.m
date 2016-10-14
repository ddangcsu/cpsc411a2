//
//  Course.m
//  Assignment2
//
//  Created by david on 10/11/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import "Course.h"

@implementation Course

-(instancetype) initWithName: (NSString*) name hWeight: (float) homework
                     mWeight: (float) midterm fWeight: (float) final {
    self = [super init];
    if (self) {
        self.courseName = name;
        self.hWeight = homework;
        self.mWeight = midterm;
        self.fWeight = final;
        self.hScore = 0;
        self.mScore = 0;
        self.fScore = 0;
        
        if (self.courseName == nil || self.hWeight < 0 || self.hWeight > 100
            || self.mWeight < 0 || self.mWeight > 100
            || self.fWeight < 0 || self.fWeight > 100) {
            return nil;
        }
    }
    return self;
}

+(instancetype) newCourse: (NSString*) name hWeight:(float) homework
                  mWeight: (float) midterm fWeight: (float) final {
    
    return [[self alloc] initWithName:name hWeight:homework mWeight:midterm fWeight:final];
}

-(NSString*) getWeights {
    NSString *output = [NSString stringWithFormat:@"hWeight: %.2f mWeight: %.2f fWeight: %.2f",
                        self.hWeight, self.mWeight, self.fWeight];
    return output;
}

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
