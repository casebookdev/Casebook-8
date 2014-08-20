//
//  Question.h
//  Casebook 8
//
//  Created by Marcus Bloice on 20/08/14.
//  Copyright (c) 2014 Marcus D. Bloice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Choice, Record;

@interface Question : NSManagedObject

@property (nonatomic, retain) NSString * questionFeedback;
@property (nonatomic, retain) NSString * questionText;
@property (nonatomic, retain) NSSet *choices;
@property (nonatomic, retain) Record *record;
@end

@interface Question (CoreDataGeneratedAccessors)

- (void)addChoicesObject:(Choice *)value;
- (void)removeChoicesObject:(Choice *)value;
- (void)addChoices:(NSSet *)values;
- (void)removeChoices:(NSSet *)values;

@end
