//
//  Student.h
//  Assignment2
//
//  Created by david on 10/12/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"

@interface Student : NSObject <NSCoding>

// MARK: Public Properties
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *CWID;
@property (strong, nonatomic) NSMutableArray<Course*> *enrolledCourses;

// MARK: Initialization
-(instancetype) initWithFirstName: (NSString*) first lastName: (NSString*) last andCWID:(NSString*) cwid;
+(instancetype) newStudentFirstName: (NSString*) first lastName: (NSString*) last andCWID:(NSString*) cwid;

// MARK: Methods
-(NSString*) fullName;
+(NSURL*) getArchivePath;

// MARK: Override method
-(BOOL)isEqual:(Student*) object;

@end
