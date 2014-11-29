//
//  ViewController.h
//  GroupMate
//
//  Created by K MacDonald on 2014-10-29.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meeting.h"
#import "MeetingTableViewCell.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *meetingList;
}

@property (weak, nonatomic) IBOutlet UITableView *meetingListTable;
@property (strong, nonatomic) IBOutlet UISegmentedControl *dateOrLocation;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;

- (void)setMeetingList:(NSMutableArray*) meetingListCopy;
- (IBAction)unwindToList:(UIStoryboardSegue *)segue;
- (IBAction)sortTable:(id)sender;
- (IBAction)search:(id)sender;


@end

