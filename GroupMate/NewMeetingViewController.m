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
    int new;//Keeps track if meeting is new or being saved again
    UIAlertView *alert;
    BOOL cancelConfirmed;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    newMeeting = [[Meeting alloc] init];
    new = true;
    
    cancelConfirmed = false;
    
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
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
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
    //Get meeting name
    if(![self.meetingName.text  isEqual: @""]){
        //If user has created a cutom meeting name, use it
        [newMeeting setName:self.meetingName.text];
    }else{
        //If user has not created a custom meeting name, make meeting name
        //"New Meeting - " plus the date and time of the meeting
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        NSDate *date = [NSDate date];
        NSString *dateString = [dateFormatter stringFromDate:date];
        NSString *meetingTitle = [NSString stringWithFormat:@"New Meeting - %@", dateString];
        [newMeeting setName:meetingTitle];
    }
    
    //Convert colourIndex into string representation of colour
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
    
    //set meeting notes
    [newMeeting setNotes:self.notes.text];
    
    if(new){
        //If meeting has not been saved before, add it to meetingList
        [meetingList addObject:newMeeting];
        new = false;
    }else{
        //If meeting has  been saved before, replace last item in meetingList
        [meetingList replaceObjectAtIndex:[meetingList count] - 1 withObject:newMeeting];
    }
    
}

- (void)setMeetingList:(NSMutableArray*) meetingListCopy{
    meetingList = meetingListCopy;
}

- (IBAction)confirmCancel:(id)sender {
    alert = [[UIAlertView alloc]
             initWithTitle:@"Are you sure you wish to cancel?"
             message:@"Your meeting will not be saved"
             delegate:self
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@"Ok",
             nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //If propose button selected...
    if (buttonIndex == 1) {//Ok
        cancelConfirmed = true;
        [self performSegueWithIdentifier:@"UnwindToList" sender:self];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"UnwindToList"]){
        if (cancelConfirmed == true) {
            return true;
        }else{
            return false;
        }
    }
    return true;
}

@end
