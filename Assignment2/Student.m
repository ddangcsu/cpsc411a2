//
//  Student.m
//  Assignment2
//
//  Created by david on 10/12/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import "Student.h"

@implementation Student

// MARK: NSCoding
static NSString* fNameKey = @"firstName";
static NSString* lNameKey = @"lastName";
static NSString* cwidKey = @"CWID";
static NSString* enrolledCoursesKey = @"enrolledCourses";


-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSString *first = [aDecoder decodeObjectForKey:fNameKey];
    NSString *last = [aDecoder decodeObjectForKey:lNameKey];
    NSString *cwid = [aDecoder decodeObjectForKey:cwidKey];
    NSMutableArray *enrolled = [aDecoder decodeObjectForKey: enrolledCoursesKey];
    
    self = [self initWithFirstName:first lastName:last andCWID:cwid];
    self.enrolledCourses = enrolled;
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject: self.firstName forKey: fNameKey];
    [aCoder encodeObject: self.lastName forKey: lNameKey];
    [aCoder encodeObject:self.CWID forKey:cwidKey];
    [aCoder encodeObject:self.enrolledCourses forKey:enrolledCoursesKey];
}

+(NSURL*) getArchivePath {
    NSURL* archivePath = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject]URLByAppendingPathComponent:@"Assignment2Student"];
    return archivePath;
}

// MARK: Initialization
-(instancetype) initWithFirstName: (NSString*) first lastName: (NSString*) last andCWID:(NSString*) cwid {
    self = [super init];
    if (self) {
        self.firstName = first;
        self.lastName = last;
        self.CWID = cwid;
        self.enrolledCourses = [[NSMutableArray alloc] init];
    }
    return self;
}

+(instancetype) newStudentFirstName: (NSString*) first lastName: (NSString*) last andCWID:(NSString*) cwid {
    
    return [[self alloc] initWithFirstName:first lastName:last andCWID:cwid];
    
}

// MARK: Override methods
-(BOOL)isEqual:(Student*) object {
    return (
            [self.firstName isEqualToString: object.firstName] &&
            [self.lastName isEqualToString: object.lastName] &&
            [self.CWID isEqualToString:object.CWID] &&
            self.enrolledCourses.count == object.enrolledCourses.count
            
            );
}

// MARK: Methods and Actions
-(NSString*) fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}



@end
