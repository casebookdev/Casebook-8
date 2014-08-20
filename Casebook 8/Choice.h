//
//  Choice.h
//  Casebook 8
//
//  Created by Marcus Bloice on 20/08/14.
//  Copyright (c) 2014 Marcus D. Bloice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Question;

@interface Choice : NSManagedObject

@property (nonatomic, retain) NSNumber * choiceCorrect;
@property (nonatomic, retain) NSString * choiceText;
@property (nonatomic, retain) Question *question;

@end
