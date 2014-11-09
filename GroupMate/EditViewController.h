//
//  EditViewController.h
//  GroupMate
//
//  Created by K MacDonald on 2014-11-09.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meeting.h"

@interface EditViewController : UIViewController{
    Meeting *meeting;
}

@property (weak, nonatomic) IBOutlet UIButton *colourPicker;
@property (weak, nonatomic) IBOutlet UITextField *meetingName;
@property (weak, nonatomic) IBOutlet UITextView *notes;

- (void) deleteMeeting;
- (void) setMeeting:(Meeting*)currMeeting;
- (IBAction)changeColourTag:(id)sender;
- (IBAction)updateMeetingName:(id)sender;

@end
