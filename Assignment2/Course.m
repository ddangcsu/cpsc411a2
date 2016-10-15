//
//  Course.m
//  Assignment2
//
//  Created by david on 10/11/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import "Course.h"

@implementation Course

// MARK: NSCoding
static NSString* nameKey = @"courseName";
static NSString* hWeightKey = @"hWeight";
static NSString* mWeightKey = @"mWeight";
static NSString* fWeightKey = @"fWeight";
static NSString* hScoreKey  = @"hScore";
static NSString* mScoreKey  = @"mScore";
static NSString* fScoreKey  = @"fScore";

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSString *name = [aDecoder decodeObjectForKey:nameKey];
    float hWeight =[aDecoder decodeFloatForKey:hWeightKey];
    float mWeight =[aDecoder decodeFloatForKey:mWeightKey];
    float fWeight =[aDecoder decodeFloatForKey:fWeightKey];
    float hScore =[aDecoder decodeFloatForKey:hScoreKey];
    float mScore =[aDecoder decodeFloatForKey:mScoreKey];
    float fScore =[aDecoder decodeFloatForKey:fScoreKey];
    
    self = [self initWithName:name hWeight:hWeight mWeight:mWeight fWeight:fWeight];
    [self setHomeworkScore:hScore midtermScore:mScore finalScore:fScore];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject: self.courseName forKey: nameKey];
    [aCoder encodeFloat:self.hWeight forKey:hWeightKey];
    [aCoder encodeFloat:self.mWeight forKey:mWeightKey];
    [aCoder encodeFloat:self.fWeight forKey:fWeightKey];
    [aCoder encodeFloat:self.hScore forKey:hScoreKey];
    [aCoder encodeFloat:self.mScore forKey:mScoreKey];
    [aCoder encodeFloat:self.fScore forKey:fScoreKey];
}

+(NSURL*) getArchivePath {
    NSURL* archivePath = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject]URLByAppendingPathComponent:@"Assignment2Course"];
    return archivePath;
}

// MARK: Initialization
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

// MARK: Override methods
-(BOOL)isEqual:(Course*) object {
    return (
        [self.courseName isEqualToString: object.courseName] &&
            self.hWeight == object.hWeight &&
            self.mWeight == object.mWeight &&
            self.fWeight == object.fWeight
    );
}

// MARK: Methods and Actions
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

-(float)getScoreAverage {
    // Get the average score for this course
    return (self.hScore * self.hWeight/100.0 +
            self.mScore * self.mWeight/100.0 +
            self.fScore * self.fWeight/100.0);
}

@end
