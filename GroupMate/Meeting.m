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

@end
