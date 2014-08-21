//
//  Case.h
//  Casebook 8
//
//  Created by Marcus Bloice on 21/08/14.
//  Copyright (c) 2014 Marcus D. Bloice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Keyword, MeshTerm, Record;

@interface Case : NSManagedObject

@property (nonatomic, retain) NSString * caseDescription;
@property (nonatomic, retain) NSString * caseTitle;
@property (nonatomic, retain) NSSet *keywords;
@property (nonatomic, retain) NSSet *meshTerms;
@property (nonatomic, retain) NSSet *records;
@end

@interface Case (CoreDataGeneratedAccessors)

- (void)addKeywordsObject:(Keyword *)value;
- (void)removeKeywordsObject:(Keyword *)value;
- (void)addKeywords:(NSSet *)values;
- (void)removeKeywords:(NSSet *)values;

- (void)addMeshTermsObject:(MeshTerm *)value;
- (void)removeMeshTermsObject:(MeshTerm *)value;
- (void)addMeshTerms:(NSSet *)values;
- (void)removeMeshTerms:(NSSet *)values;

- (void)addRecordsObject:(Record *)value;
- (void)removeRecordsObject:(Record *)value;
- (void)addRecords:(NSSet *)values;
- (void)removeRecords:(NSSet *)values;

@end
