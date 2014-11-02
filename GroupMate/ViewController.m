//
//  ViewController.m
//  GroupMate
//
//  Created by K MacDonald on 2014-10-29.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Add '+' button to UIBarButton to create new meeting
    UIBarButtonItem *newMeeting = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(createNewMeeting)];
    //Add hamburger button to UIBarButton to view profile
    UIBarButtonItem * viewProfileButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                                                                 target:self
                                                                                 action:@selector(viewProfile)];
    
    [self.navigationItem setRightBarButtonItem:newMeeting];
    [self.navigationItem setLeftBarButtonItem:viewProfileButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) createNewMeeting{
    [self performSegueWithIdentifier:@"newMeetingSegue"sender:self];
}

-(void) viewProfile{
    
}

@end
