//
//  JSONParser.swift
//  Casebook 8
//
//  Created by Marcus Bloice on 05/08/14.
//  Copyright (c) 2014 Marcus D. Bloice. All rights reserved.
//

import Foundation
import CoreData
import UIKit

// My imports
import Record.h
import Question.h
// check how this is done properly...

// Here we shall import the parsing code from the previous project and convert it into Swift code. 
// As an example JSON file, will parse the file that was uploaded with the BMC article.
// Note: Inlclude reference to Casebook article here.

// JSON (JMCR.json) that shall be parsed here for testing is from:
// Ammannagari N, Chikoti S, Bravin E: Hodgkin's lymphoma presenting as a complex paraneoplastic 
// neurological syndrome: a case report. Journal of Medical Case Reports 2013, 7:96.


func parseJSONFile(fileToParsen: NSString) -> NSString{
    // For the moment we will return a string, but later we'll return a Case object.
    
    // We shall first read a hard coded filename in, namely JMCR.json
    // let is used for constants, var for variables
    let filename:NSString = "JMCR"
    var err:NSError
    
    
    // Let's now store our App Delegate, we need this to access the SQL Lite database and so on.
    var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var context:NSManagedObjectContext = appDel.managedObjectContext
    
    var newCase = NSEntityDescription.insertNewObjectForEntityForName("Case", inManagedObjectContext: context) as NSManagedObject
    
    newCase.setValue("JMCR Test Case", forKey: "caseTitle")
    newCase.setValue("A test case that we will extract from the BMC journal sample case JSON file", forKey: "caseDescription")
    
    context.save(nil) // We shall add error handling later by supplying an error:NSErrorPointer object.
    
    // Test the outout
    println(newCase)
    println("Case saved...")
    
    // NOTE TO SELF!!!
    // The next step is to generate the classes fromthe XC Data Model. Then we can input Case objects, with 
    // Record and Question objects within these Case objects. 
    // NEXT STEP: Auto-generate classes from data model!
    
    
    
    // Now we can load the JSON by translating the code from the other Casebook project
    
    
    
    
    
    
    return filename
}