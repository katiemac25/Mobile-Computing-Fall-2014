//
//  EditViewController.m
//  GroupMate
//
//  Created by K MacDonald on 2014-11-09.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController{
    int colourIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Add delete button to UIBarButton
    UIBarButtonItem *saveMeetingButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                                       target:self
                                                                                       action:@selector(deleteMeeting)];
    [self.navigationItem setRightBarButtonItem:saveMeetingButton];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    [[self.notes layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.notes layer] setBorderWidth:1];
    [[self.notes layer] setCornerRadius:5];
    
    [self.navigationItem setTitle:meeting.name];
    [self.meetingName setText:meeting.name];
    
    [self.notes setText:meeting.notes];
    
    if([meeting.colour  isEqual: @"Red"]){
        [self.colourPicker setBackgroundColor:[UIColor redColor]];
        colourIndex = 0;
    }else if([meeting.colour  isEqual: @"Orange"]){
        [self.colourPicker setBackgroundColor:[UIColor orangeColor]];
        colourIndex = 1;
    }else if([meeting.colour  isEqual: @"Yellow"]){
        [self.colourPicker setBackgroundColor:[UIColor yellowColor]];
        colourIndex = 2;
    }else if([meeting.colour  isEqual: @"Green"]){
        [self.colourPicker setBackgroundColor:[UIColor greenColor]];
        colourIndex = 3;
    }else if([meeting.colour  isEqual: @"Blue"]){
        [self.colourPicker setBackgroundColor:[UIColor blueColor]];
        colourIndex = 4;
    }else if([meeting.colour  isEqual: @"Purple"]){
        [self.colourPicker setBackgroundColor:[UIColor purpleColor]];
        colourIndex = 5;
    }else if([meeting.colour  isEqual: @"Black"]){
        [self.colourPicker setBackgroundColor:[UIColor blackColor]];
        colourIndex = 6;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) deleteMeeting{
    
}

- (void) setMeeting:(Meeting*)currMeeting{
    meeting = currMeeting;
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

@end
