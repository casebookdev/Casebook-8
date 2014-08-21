//
//  Record.h
//  Casebook 8
//
//  Created by Marcus Bloice on 21/08/14.
//  Copyright (c) 2014 Marcus D. Bloice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Case, Question;

@interface Record : NSManagedObject

@property (nonatomic, retain) NSString * annotation;
@property (nonatomic, retain) NSString * department;
@property (nonatomic, retain) NSData * file;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * recordTitle;
@property (nonatomic, retain) Case *caseRelationship;
@property (nonatomic, retain) Question *question;

@end
