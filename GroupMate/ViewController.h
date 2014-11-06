//
//  ViewController.h
//  GroupMate
//
//  Created by K MacDonald on 2014-10-29.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meeting.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *meetingList;
}

@property (weak, nonatomic) IBOutlet UITableView *meetingListTable;

- (void) addMeeting:(Meeting*)meeting;
- (void)setMeetingList:(NSMutableArray*) meetingListCopy;

@end

