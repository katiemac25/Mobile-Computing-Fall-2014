//
//  ViewController.m
//  GroupMate
//
//  Created by K MacDonald on 2014-10-29.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "ViewController.h"
#import "NewMeetingViewController.h"
#import "MeetingViewController.h"
#import "Meeting.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSUInteger currMeetingIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    meetingList = [[NSMutableArray alloc] init];
    currMeetingIndex = -1;
    
    //Add '+' button to UIBarButton to create new meeting
    UIBarButtonItem *newMeeting = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(addMeeting)];
    //Add hamburger button to UIBarButton to view profile
    UIBarButtonItem * viewProfileButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                                                                 target:self
                                                                                 action:@selector(viewProfile)];
    
    [self.navigationItem setRightBarButtonItem:newMeeting];
    [self.navigationItem setLeftBarButtonItem:viewProfileButton];
    
    //Test meetings
    /*Meeting *testMeeting1 = [[Meeting alloc] init];
    [testMeeting1 setName:@"Test 1"];
    [testMeeting1 setColour:@"Red"];
    
    [meetingList addObject:testMeeting1];
    
    Meeting *testMeeting2 = [[Meeting alloc] init];
    [testMeeting2 setName:@"Test 2"];
    [testMeeting2 setColour:@"Blue"];
    
    [meetingList addObject:testMeeting2];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [meetingList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeetingCell" forIndexPath:indexPath];
    
    NSUInteger index = [meetingList count] - indexPath.row - 1;
    Meeting *currMeeting = (Meeting*)[meetingList objectAtIndex:index];
    
    UILabel *colourTag = (UILabel *)[cell viewWithTag:101];
    if([currMeeting.colour isEqual: @"Red"]){
        colourTag.backgroundColor = [UIColor redColor];
    }else if([currMeeting.colour isEqual: @"Orange"]){
        colourTag.backgroundColor = [UIColor orangeColor];
    }else if([currMeeting.colour isEqual: @"Yellow"]){
        colourTag.backgroundColor = [UIColor yellowColor];
    }else if([currMeeting.colour isEqual: @"Green"]){
        colourTag.backgroundColor = [UIColor greenColor];
    }else if([currMeeting.colour isEqual: @"Blue"]){
        colourTag.backgroundColor = [UIColor blueColor];
    }else if([currMeeting.colour isEqual: @"Purple"]){
        colourTag.backgroundColor = [UIColor purpleColor];
    }else if([currMeeting.colour isEqual: @"Black"]){
        colourTag.backgroundColor = [UIColor blackColor];
    }
    
    UILabel *meetingNameLabel = (UILabel *)[cell viewWithTag:100];
    meetingNameLabel.text = currMeeting.name;
    
    return cell;
}

//Cell selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    currMeetingIndex = [meetingList count] - indexPath.row - 1;
    
    [self performSegueWithIdentifier:@"viewMeetingSegue"sender:self];
}

-(void) addMeeting{
    [self performSegueWithIdentifier:@"newMeetingSegue"sender:self];
}

-(void) viewProfile{
    
}

- (void) addMeeting:(Meeting*)meeting{
    [meetingList addObject:meeting];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"newMeetingSegue"]) {
        NewMeetingViewController *controller = [segue destinationViewController];
        
        [controller setMeetingList:meetingList];
    }else if ([segue.identifier isEqualToString:@"viewMeetingSegue"]){
         MeetingViewController *controller = [segue destinationViewController];
        [controller setMeeting:(Meeting*)[meetingList objectAtIndex:currMeetingIndex]];
    }
}

- (void)setMeetingList:(NSMutableArray*) meetingListCopy{
    meetingList = meetingListCopy;
}

- (void) viewWillAppear:(BOOL)animated{
    [self.meetingListTable reloadData];
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue{
    if ([segue.identifier isEqualToString:@"leaveNewMeetingSegue"]) {
        ViewController *controller = [segue destinationViewController];
        
        [controller setMeetingList:meetingList];
    }
}

@end
