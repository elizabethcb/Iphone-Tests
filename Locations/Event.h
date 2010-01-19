//
//  Event.h
//  Locations
//
//  Created by Brandon Coston on 11/16/09.
//  Copyright 2009 Slate Technologies. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Event :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSDate * creationDate;

@end



