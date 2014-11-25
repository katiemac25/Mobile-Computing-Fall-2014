//
//  Meeting.m
//  GroupMate
//
//  Created by K MacDonald on 2014-11-05.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "Meeting.h"


@implementation Meeting

@synthesize name;
@synthesize colour;
@synthesize notes;
@synthesize date;
@synthesize address;

-(void) setName:(NSString*)meetingName{
    name = meetingName;
}

-(void) setColour:(NSString*)meetingColour{
    colour = meetingColour;
}

- (void) setNotes:(NSString*)meetingNotes{
    notes = meetingNotes;
}

- (void) setDate:(NSDate*)meetingDate{
    date = meetingDate;
}

- (void) setAddress:(NSString*)meetingAddress{
    address = meetingAddress;
}

#pragma mark NSCoding
- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:name forKey:@"name"];
    [encoder encodeObject:colour forKey:@"colour"];
    [encoder encodeObject:notes forKey:@"notes"];
    [encoder encodeObject:date forKey:@"date"];
    [encoder encodeObject:address forKey:@"address"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self){
        name = [decoder decodeObjectForKey:@"name"];
        colour = [decoder decodeObjectForKey:@"colour"];
        notes = [decoder decodeObjectForKey:@"notes"];
        date = [decoder decodeObjectForKey:@"date"];
        address = [decoder decodeObjectForKey:@"address"];
    }
    return self;
}

@end
