//
//  MeetingViewController.m
//  GroupMate
//
//  Created by K MacDonald on 2014-11-07.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "MeetingViewController.h"
#import "EditViewController.h"

@interface MeetingViewController ()

@end

@implementation MeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updatePage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"editSegue"]){
        EditViewController *controller = [segue destinationViewController];
        [controller setMeeting:meeting];
        [controller setMeetingList:meetingList];
        [controller setIndex:index];
    }
}

- (void)updatePage{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSDate *date = meeting.date;
    NSString *dateString = [dateFormatter stringFromDate:date];
    [self.dateLabel setText:dateString];
    [self.notesLabel setText:meeting.notes];
    [self.navigationItem setTitle:meeting.name];
    
    [self updateImageViews];
    
    if([meeting.colour  isEqual: @"Red"]){
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
    }else if([meeting.colour  isEqual: @"Orange"]){
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor orangeColor]}];
    }else if([meeting.colour  isEqual: @"Yellow"]){
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor yellowColor]}];
    }else if([meeting.colour  isEqual: @"Green"]){
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor greenColor]}];
    }else if([meeting.colour  isEqual: @"Blue"]){
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
    }else if([meeting.colour  isEqual: @"Purple"]){
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor purpleColor]}];
    }else if([meeting.colour  isEqual: @"Black"]){
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    }
}
- (IBAction)editButton:(id)sender {
}

- (IBAction)backButton:(id)sender {
}

- (void) setMeeting:(Meeting*)currMeeting{
    meeting = currMeeting;
}
- (void) setIndex:(int)currIndex{
    index = currIndex;
}
- (void)setMeetingList:(NSMutableArray*) meetingListCopy{
    meetingList = meetingListCopy;
}

- (IBAction)unwindToDisplay:(UIStoryboardSegue *)segue{
    if ([segue.identifier isEqualToString:@"UnwindToDisplay"]) {
        MeetingViewController *controller = [segue destinationViewController];
        
        [controller setMeetingList:meetingList];
    }else if ([segue.identifier isEqualToString:@"UnwindToDisplayFromEdit"]) {
        MeetingViewController *controller = [segue destinationViewController];
        
        [controller setMeetingList:meetingList];
        [controller setMeeting:meeting];
        [controller updatePage];
    }
    [self updateImageViews];
}

- (void)updateImageViews{
    self.image1.image = nil;
    self.image2.image = nil;
    self.image3.image = nil;
    
    if(meeting.images.count >= 1){
        self.image1.image = [UIImage imageWithData:meeting.images[0]];
    }
    
    if(meeting.images.count >= 2){
        self.image2.image = [UIImage imageWithData:meeting.images[1]];
    }
    
    if(meeting.images.count == 3){
        self.image3.image = [UIImage imageWithData:meeting.images[2]];
    }
}
@end
