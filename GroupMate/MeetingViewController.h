//
//  MeetingViewController.h
//  GroupMate
//
//  Created by K MacDonald on 2014-11-07.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meeting.h"

@interface MeetingViewController : UIViewController <UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>{
    NSMutableArray *meetingList;
    Meeting *meeting;
    int index;
}

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *notesLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *imageCollectionView;

- (void) setMeeting:(Meeting*)currMeeting;
- (void) setIndex:(int)currIndex;
- (IBAction)unwindToDisplay:(UIStoryboardSegue *)segue;
- (void)setMeetingList:(NSMutableArray*) meetingListCopy;

@end
