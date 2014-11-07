//
//  NewMeetingViewController.m
//  GroupMate
//
//  Created by K MacDonald on 2014-10-29.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "NewMeetingViewController.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Meeting.h"

@interface NewMeetingViewController ()

@end

@implementation NewMeetingViewController{
    int colourIndex;
    Meeting *newMeeting;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    newMeeting = [[Meeting alloc] init];
    
    //Get date and time when meeting starts
    [newMeeting setDate:[NSDate date]];

    //Add save button to UIBarButton
    UIBarButtonItem *saveMeetingButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                        target:self
                                                                                        action:@selector(saveMeeting)];
    [self.navigationItem setRightBarButtonItem:saveMeetingButton];
    
    colourIndex = 0;
    [[self.notes layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.notes layer] setBorderWidth:1];
    [[self.notes layer] setCornerRadius:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateMeetingName:(id)sender {
    if(![self.meetingName.text  isEqual: @""]){
        [self.navigationItem setTitle:self.meetingName.text];
    }else{
        [self.navigationItem setTitle:@"New Meeting"];
    }
}

- (IBAction)changeColourTag:(id)sender {
    if(colourIndex == 0){
        [self.colourPicker setBackgroundColor:[UIColor orangeColor]];
        colourIndex++;
    }else if(colourIndex == 1){
        [self.colourPicker setBackgroundColor:[UIColor yellowColor]];
        colourIndex++;
    }else if(colourIndex == 2){
        [self.colourPicker setBackgroundColor:[UIColor greenColor]];
        colourIndex++;
    }else if(colourIndex == 3){
        [self.colourPicker setBackgroundColor:[UIColor blueColor]];
        colourIndex++;
    }else if(colourIndex == 4){
        [self.colourPicker setBackgroundColor:[UIColor purpleColor]];
        colourIndex++;
    }else if(colourIndex == 5){
        [self.colourPicker setBackgroundColor:[UIColor blackColor]];
        colourIndex++;
    }else if(colourIndex == 6){
        [self.colourPicker setBackgroundColor:[UIColor redColor]];
        colourIndex = 0;
    }
    
}

-(void) saveMeeting{
    if(![self.meetingName.text  isEqual: @""]){
        [newMeeting setName:self.meetingName.text];
    }else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        NSDate *date = [NSDate date];
        NSString *dateString = [dateFormatter stringFromDate:date];
        NSString *meetingTitle = [NSString stringWithFormat:@"New Meeting - %@", dateString];
        [newMeeting setName:meetingTitle];
    }
    
    if(colourIndex == 0){
        [newMeeting setColour:@"Red"];
    }else if(colourIndex == 1){
        [newMeeting setColour:@"Orange"];
    }else if(colourIndex == 2){
        [newMeeting setColour:@"Yellow"];
    }else if(colourIndex == 3){
        [newMeeting setColour:@"Green"];
    }else if(colourIndex == 4){
        [newMeeting setColour:@"Blue"];
    }else if(colourIndex == 5){
        [newMeeting setColour:@"Purple"];
    }else if(colourIndex == 6){
        [newMeeting setColour:@"Black"];
    }
    
    [newMeeting setNotes:self.notes.text];
    
    [meetingList addObject:newMeeting];
}

- (void)setMeetingList:(NSMutableArray*) meetingListCopy{
    meetingList = meetingListCopy;
}


@end
