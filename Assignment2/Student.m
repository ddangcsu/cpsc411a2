//
//  Student.m
//  Assignment2
//
//  Created by david on 10/12/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import "Student.h"

@implementation Student

-(instancetype) initWithFirstName: (NSString*) first lastName: (NSString*) last andCWID:(NSString*) cwid {
    self = [super init];
    if (self) {
        self.firstName = first;
        self.lastName = last;
        self.CWID = cwid;
        self.enrolledCourses = nil;
    }
    return self;
}

+(instancetype) newStudentFirstName: (NSString*) first lastName: (NSString*) last andCWID:(NSString*) cwid {
    
    return [[self alloc] initWithFirstName:first lastName:last andCWID:cwid];
    
}

-(NSString*) fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}



@end
