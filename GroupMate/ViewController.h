//
//  ViewController.h
//  GroupMate
//
//  Created by K MacDonald on 2014-10-29.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *meetingList;
}

@property (weak, nonatomic) IBOutlet UITableView *meetingListTable;

@end

