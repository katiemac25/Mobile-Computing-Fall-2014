//
//  MeetingViewController.m
//  GroupMate
//
//  Created by K MacDonald on 2014-11-07.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "MeetingViewController.h"

@interface MeetingViewController ()

@end

@implementation MeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSDate *date = meeting.date;
    NSString *dateString = [dateFormatter stringFromDate:date];
    [self.dateLabel setText:dateString];
    [self.notesLabel setText:meeting.notes];
    [self.navigationItem setTitle:meeting.name];
    
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

- (IBAction)editButton:(id)sender {
}

- (IBAction)backButton:(id)sender {
}

- (void) setMeeting:(Meeting*)currMeeting{
    meeting = currMeeting;
}
@end
