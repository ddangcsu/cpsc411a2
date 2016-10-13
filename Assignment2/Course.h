//
//  Course.h
//  Assignment2
//
//  Created by david on 10/11/16.
//  Copyright © 2016 David Dang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject

// MARK: Properties
@property (strong, nonatomic) NSString *courseName;
@property (assign, nonatomic) float hWeight;
@property (assign, nonatomic) float mWeight;
@property (assign, nonatomic) float fWeight;

// MARK: Methods
-(instancetype) initWithName: (NSString*) name
                     hWeight: (float) homework
                     mWeight: (float) midterm
                     fWeight: (float) final;

+(instancetype) newCourse: (NSString*) name
                  hWeight:(float) homework
                  mWeight: (float) midterm
                  fWeight: (float) final;

-(NSString*) getWeights;

@end
