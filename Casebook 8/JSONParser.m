//
//  JSONParser.m
//  Casebook
//
//  Created by Marcus Bloice on 10/8/13.
//  Copyright (c) 2013 Marcus D. Bloice. All rights reserved.
//

#import "JSONParser.h"

// Import the classes we need for the generation of each case's elements.
#import "Case.h"
#import "MeshTerm.h"
#import "Keyword.h"
#import "Record.h"
#import "Question.h"
#import "Choice.h"


@implementation JSONParser


// This function will parse the case files imported into the app.
// We generate the interface elements later when we access the database
// and extract the cases then. 
+ (Case *) parseJSONfile:(NSString *)withFile{
    
    
    // Perform some tests for loading JSON.
    // Let's first load the test JSON file.
    NSError *err = nil;
    NSString *filename = @"newformat";
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename ofType:@"json"]];
    NSDictionary *jsonCase = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    
    // Use the context to get the entity stuff.
    id delegate  = [[UIApplication sharedApplication] delegate];
    managedObjectContext = [delegate managedObjectContext];
    
    Case *c = [NSEntityDescription insertNewObjectForEntityForName:@"Case" inManagedObjectContext:self.managedObjectContext];
    c.caseTitle = [jsonCase objectForKey:@"caseTitle"];
    c.caseDescription = [jsonCase objectForKey:@"caseDescription"];
    
    // Let's get the MeSH terms out of there.
    // NSSet *meshTerms = [NSSet setWithArray:[jsonCase objectForKey:@"meshTerms"]];
    
    // Fix all this so we don't need so many of these temporary variables (do it like the MeSH terms below)
    NSArray *meshStringsArray = [jsonCase objectForKey:@"meshTerms"];
    
    NSMutableSet *meshTerms;
    for(int i = 0; i < [meshStringsArray count]; i++){
        MeshTerm *m = [NSEntityDescription insertNewObjectForEntityForName:@"MeshTerm" inManagedObjectContext:self.managedObjectContext];
        m.meshTerm = [meshStringsArray objectAtIndex:i];
        [meshTerms addObject:m];
        m.caseRelationship = c;
    }
    
    NSSet *finalMeshSet = [meshTerms copy];
    [c addMeshTerms:finalMeshSet];
    
    
    NSMutableSet *keywordsMutable;
    for(int i = 0; i < [[jsonCase objectForKey:@"keywords"] count]; i++){
        Keyword *k = [NSEntityDescription insertNewObjectForEntityForName:@"Keyword" inManagedObjectContext:self.managedObjectContext];
        k.keyword = [[jsonCase objectForKey:@"keywords"] objectAtIndex:i];
        [keywordsMutable addObject:k];
        k.caseRelationship = c;
    }
    
    [c addKeywords:[keywordsMutable copy]];
    
    // Get all the patient records from the JSON file.
    // To do this, we need to get the array of departments, and choose each patient record from there.
    // We get the text from the JSON file and assign it to the departent attribute of the
    // Record entity- there is currently no Department entity!! This may change later.
    
    // This will be an array, but later we can get dictionaries out of the array...
    NSArray *departmentsArray = [jsonCase objectForKey:@"departments"];
    
    int caseOrder = 0;
    
    for(int i = 0; i < [departmentsArray count]; i++){
        
        // Each department will have a certain number of patient records,
        // so we'll go through each patient record and build up the records one by one.
        // The patient records are dictionaries, so we can extract them from the array as such.
        
        NSDictionary *currentDepartment = [departmentsArray objectAtIndex:i];
        NSArray *currentDepartmentPatientRecords = [currentDepartment objectForKey:@"patientRecords"];
        
        // Now we loop through each department's patient records. I will need to put checks into place for
        // those that contain no patient records and so on.
        // Each record can be placed into a dictionary. We then extract what we need.
        for(int j = 0; j < [currentDepartmentPatientRecords count]; j++){
            
            NSDictionary *currentPatientRecord = [currentDepartmentPatientRecords objectAtIndex:j];
            
            // Departments can contain patient records or questions. We need to differentiate here between them before
            // we add them to the database. If they are questions we create new Question objects and link them to the
            // Record object.
            
            Record *r = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:self.managedObjectContext];
            r.annotation = [currentPatientRecord objectForKey:@"annotation"];
            r.file = [[currentPatientRecord objectForKey:@"filename"] dataUsingEncoding:NSUTF8StringEncoding]; // Temporary, will save image data here when we are loading ZIPs.
            r.department = [currentDepartment objectForKey:@"departmentTitle"];
            r.recordTitle = [currentPatientRecord objectForKey:@"recordTitle"];
            
            // if the patient record has a question, we include it here.
            
            if([currentPatientRecord objectForKey:@"question"] != nil){
                
                NSDictionary *currentQuestion = [currentPatientRecord objectForKey:@"question"];
                NSLog(@"%@", [currentQuestion objectForKey:@"questionText"]);
                
                Question *q = [NSEntityDescription insertNewObjectForEntityForName:@"Question" inManagedObjectContext:self.managedObjectContext];
                q.questionText = [currentQuestion objectForKey:@"questionText"];
                // Come back here - prob best to do this at the end when all the choices are complete.
                q.record = r;
                
                NSArray *questionChoices = [currentQuestion objectForKey:@"questionChoices"];
                NSArray *correctAnswers = [currentQuestion objectForKey:@"correct"];
                NSLog(@"Choices: %@\n Answers: %@", questionChoices, correctAnswers);
                
                for(int k = 0; k < [questionChoices count]; k++){
                    
                    Choice *c = [NSEntityDescription insertNewObjectForEntityForName:@"Choice" inManagedObjectContext:self.managedObjectContext];
                    c.choiceText = [questionChoices objectAtIndex:k];
                    
                    // Cannot think of a better way of doing this right now.
                    // ALSO: Take a long look at this and see if I should not just use NSInteger...
                    for(int m = 0; m < [correctAnswers count]; m++){
                        
                        NSNumber *aCorrectAnswer = [correctAnswers objectAtIndex:m];
                        NSNumber *currentIteratedAnswer = [NSNumber numberWithInteger:k];
                        
                        
                        if(aCorrectAnswer == currentIteratedAnswer){
                            c.choiceCorrect = [NSNumber numberWithBool:YES];
                        }
                        
                    }
                    
                    [q addChoicesObject:c];
                    c.question = q;
                    
                    // This refuses to work, it crashes on runtime every time so I guess we can use an integer.
                    // BOOL found = CFArrayContainsValue((__bridge CFArrayRef)correctAnswers, CFRangeMake(0, [questionChoices count]), (CFNumberRef)[NSNumber numberWithInt:k]);
                    
                }
                
                
            }
            
            
            r.order = [NSNumber numberWithInt:caseOrder];
            caseOrder++;
            r.caseRelationship = c;
            [c addRecordsObject:r];
            
            // Parse final part of the JSON.
            NSLog(@"%@", r);
            
        }
        
    }
    
    // Let's save everything into the database
    NSError *error;
    if(![self.managedObjectContext save:&error]){
        NSLog(@"Something has gone terribly wrong: %@", error.localizedDescription);
    }
    
    NSLog(@"Case contents: %@", c);
    NSLog(@"Title: %@", [c caseTitle]);
    
    // Finished here: Case is now contained in c, we want to iterate over c and
    // get information about each record contain in there.
    
    // Now we will interate through the JSON here.
    NSMutableArray *records = [[NSMutableArray alloc] init];
    
    
    [records enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        
        NSLog(@"We are at count %lu", (unsigned long)idx);
        
    }];

    
    
    return [[Case alloc] init];
    
}


@end
