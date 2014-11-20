//
//  EditViewController.h
//  GroupMate
//
//  Created by K MacDonald on 2014-11-09.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meeting.h"

@interface EditViewController : UIViewController <UITextFieldDelegate>{
    NSMutableArray *meetingList;
    Meeting *meeting;
    int index;
}

@property (weak, nonatomic) IBOutlet UIButton *colourPicker;
@property (weak, nonatomic) IBOutlet UITextField *meetingName;
@property (weak, nonatomic) IBOutlet UITextView *notes;

- (void) setMeeting:(Meeting*)currMeeting;
- (void) setIndex:(int)currIndex;
- (IBAction)updateMeetingName:(id)sender;
- (IBAction)deleteMeeting:(id)sender;
- (void)setMeetingList:(NSMutableArray*) meetingListCopy;
- (IBAction)saveMeeting:(id)sender;
- (IBAction)changeColourTag:(id)sender;

@end
