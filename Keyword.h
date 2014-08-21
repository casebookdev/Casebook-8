//
//  Keyword.h
//  Casebook 8
//
//  Created by Marcus Bloice on 21/08/14.
//  Copyright (c) 2014 Marcus D. Bloice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Case;

@interface Keyword : NSManagedObject

@property (nonatomic, retain) NSString * keyword;
@property (nonatomic, retain) Case *caseRelationship;

@end
