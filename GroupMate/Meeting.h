//
//  Meeting.h
//  GroupMate
//
//  Created by K MacDonald on 2014-11-05.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meeting : NSObject <NSCoding>{
    NSString *name;
    NSString *colour;
    NSString *notes;
    NSDate *date;
    NSString *address;
    NSMutableArray *images;
}

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *colour;
@property(nonatomic, retain) NSString *notes;
@property(nonatomic, retain) NSDate *date;
@property(nonatomic, retain) NSString *address;
@property(nonatomic, retain) NSMutableArray *images;

- (void) setName:(NSString*)name;
- (void) setColour:(NSString*)meetingColour;
- (void) setNotes:(NSString*)meetingNotes;
- (void) setDate:(NSDate*)meetingDate;
- (void) setAddress:(NSString*)meetingAddress;
- (void) addImage:(NSData*)imageToAdd;
- (void) removeImage:(NSUInteger)index;
- (Meeting*)importFromURL:(NSURL *)importURL;

@end
