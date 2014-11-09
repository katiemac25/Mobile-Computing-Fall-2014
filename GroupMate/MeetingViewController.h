//
//  MeetingViewController.h
//  GroupMate
//
//  Created by K MacDonald on 2014-11-07.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meeting.h"

@interface MeetingViewController : UIViewController{
    Meeting *meeting;
}

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *notesLabel;

- (IBAction)editButton:(id)sender;
- (IBAction)backButton:(id)sender;
- (void) setMeeting:(Meeting*)currMeeting;
- (IBAction)unwindToDisplay:(UIStoryboardSegue *)segue;

@end
