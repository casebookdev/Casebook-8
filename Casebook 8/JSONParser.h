//
//  JSONParser.h
//  Casebook
//
//  Created by Marcus Bloice on 10/8/13.
//  Copyright (c) 2013 Marcus D. Bloice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Case.h"


@interface JSONParser : NSObject

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

+ (Case *) parseJSONfile:(NSString*) withFile;


@end
