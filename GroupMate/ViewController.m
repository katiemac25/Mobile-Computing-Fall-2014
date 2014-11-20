//
//  ViewController.m
//  GroupMate
//
//  Created by K MacDonald on 2014-10-29.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "ViewController.h"
#import "NewMeetingViewController.h"
#import "MeetingViewController.h"
#import "Meeting.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSUInteger currMeetingIndex;
    BOOL sortByDate;
    NSMutableArray *meetingDates, *meetingLocations;
    NSMutableDictionary *datesCount, *locationsCount;
    NSArray *meetingsSortedByDate, *meetingsSortedByLocation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    meetingList = [[NSMutableArray alloc] init];
    currMeetingIndex = -1;
    
    sortByDate = true;
    
    meetingDates = [[NSMutableArray alloc] init];
    meetingLocations =[[NSMutableArray alloc] init];
    datesCount = [[NSMutableDictionary alloc] init];
    locationsCount = [[NSMutableDictionary alloc] init];
    
    //Remove warning about ambiguous row height
    self.meetingListTable.rowHeight = 44;
    
    //Add '+' button to UIBarButton to create new meeting
    UIBarButtonItem *newMeeting = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(addMeeting)];
    
    [self.navigationItem setRightBarButtonItem:newMeeting];
    
    //Test meetings
    /*Meeting *testMeeting1 = [[Meeting alloc] init];
    [testMeeting1 setName:@"Test 1"];
    [testMeeting1 setColour:@"Red"];
    
    [meetingList addObject:testMeeting1];
    
    Meeting *testMeeting2 = [[Meeting alloc] init];
    [testMeeting2 setName:@"Test 2"];
    [testMeeting2 setColour:@"Blue"];
    
    [meetingList addObject:testMeeting2];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if(sortByDate){
        return meetingDates.count;
    }else{
        return meetingLocations.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return [meetingList count];
    
    NSString *sectionHeader;
    NSNumber *nsCount;
    
    if(sortByDate){
        sectionHeader = meetingDates[section];
        nsCount = [datesCount objectForKey:sectionHeader];
        return [nsCount intValue];
    }else{
        sectionHeader = meetingLocations[section];
        nsCount = [locationsCount objectForKey:sectionHeader];
        return [nsCount intValue];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //For each section, you must return here it's label
    if(sortByDate){
        return meetingDates[section];
    }else{
        return meetingLocations[section];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeetingCell" forIndexPath:indexPath];
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    Meeting *currMeeting;
    NSUInteger index;
    NSString *sectionHeader;
    NSNumber *nsCount;
    
    if(sortByDate){
        index = 0;
        for(int i = 0; i < section; i++){
            sectionHeader = meetingDates[section];
            nsCount = [datesCount objectForKey:sectionHeader];
            index += [nsCount intValue];
        }
        index += row;
        currMeeting = (Meeting*)[meetingsSortedByDate objectAtIndex:index];
        NSLog(@"%lu - %@", (unsigned long)index, currMeeting.name);
    }else{
        NSLog(@"location");
        index = 0;
        for(int i = 0; i < section; i++){
            sectionHeader = meetingLocations[section];
            nsCount = [locationsCount objectForKey:sectionHeader];
            index += [nsCount intValue];
        }
        index += row;
        currMeeting = (Meeting*)[meetingsSortedByLocation objectAtIndex:index];
        NSLog(@"%lu - %@", (unsigned long)index, currMeeting.name);
    }
    
    UILabel *colourTag = (UILabel *)[cell viewWithTag:101];
    
    if([currMeeting.colour isEqual: @"Red"]){
        colourTag.backgroundColor = [UIColor redColor];
    }else if([currMeeting.colour isEqual: @"Orange"]){
        colourTag.backgroundColor = [UIColor orangeColor];
    }else if([currMeeting.colour isEqual: @"Yellow"]){
        colourTag.backgroundColor = [UIColor yellowColor];
    }else if([currMeeting.colour isEqual: @"Green"]){
        colourTag.backgroundColor = [UIColor greenColor];
    }else if([currMeeting.colour isEqual: @"Blue"]){
        colourTag.backgroundColor = [UIColor blueColor];
    }else if([currMeeting.colour isEqual: @"Purple"]){
        colourTag.backgroundColor = [UIColor purpleColor];
    }else if([currMeeting.colour isEqual: @"Black"]){
        colourTag.backgroundColor = [UIColor blackColor];
    }
    
    UILabel *meetingNameLabel = (UILabel *)[cell viewWithTag:100];
    meetingNameLabel.text = currMeeting.name;

    return cell;
}

//Cell selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //currMeetingIndex = [meetingList count] - indexPath.row - 1;
    currMeetingIndex = indexPath.row;
    
    [self performSegueWithIdentifier:@"viewMeetingSegue"sender:self];
}

-(void) addMeeting{
    [self performSegueWithIdentifier:@"newMeetingSegue"sender:self];
}

- (void) addMeeting:(Meeting*)meeting{
    [meetingList addObject:meeting];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"newMeetingSegue"]) {
        NewMeetingViewController *controller = [segue destinationViewController];
        
        [controller setMeetingList:meetingList];
    }else if ([segue.identifier isEqualToString:@"viewMeetingSegue"]){
        MeetingViewController *controller = [segue destinationViewController];
        if(sortByDate){
            [controller setMeeting:(Meeting*)[meetingsSortedByDate objectAtIndex:currMeetingIndex]];
        }else{
            [controller setMeeting:(Meeting*)[meetingsSortedByLocation objectAtIndex:currMeetingIndex]];
        }
        //[controller setMeeting:(Meeting*)[meetingList objectAtIndex:currMeetingIndex]];
        [controller setMeetingList:meetingList];
        [controller setIndex:(int)currMeetingIndex];
    }
}

- (void)setMeetingList:(NSMutableArray*) meetingListCopy{
    meetingList = meetingListCopy;
}

- (void) viewWillAppear:(BOOL)animated{
    [self.meetingListTable reloadData];
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue{
    if ([segue.identifier isEqualToString:@"UnwindToList"]) {
        ViewController *controller = [segue destinationViewController];
        
        [controller setMeetingList:meetingList];
    }else if([segue.identifier isEqualToString:@"UnwindToListFromEdit"]){
        ViewController *controller = [segue destinationViewController];
        
        [controller setMeetingList:meetingList];
    }
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    [self getMeetingDates];
    [self getMeetingLocations];
}

- (IBAction)sortTable:(id)sender {
    if(self.dateOrLocation.selectedSegmentIndex == 0){
        //Date
        sortByDate = true;
    }else{
        //Location
        sortByDate = false;
    }
    
    //Refresh table
    [self.meetingListTable reloadData];
}

- (void) getMeetingDates{
    [datesCount removeAllObjects];
    NSNumber *nsCount;
    int incCount;
    for(int i = 0; i < meetingList.count; i++) {
        Meeting *currMeeting = meetingList[i];
        NSDate *currDate = currMeeting.date;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        NSString *dateString = [dateFormatter stringFromDate:currDate];
        
        if([meetingDates containsObject:dateString] == NO){
            [meetingDates addObject:dateString];
            [datesCount setObject:[NSNumber numberWithInt:1] forKey:dateString];
        }else{
            nsCount = [datesCount objectForKey:dateString];
            incCount = [nsCount intValue];
            nsCount = [NSNumber numberWithInt:incCount + 1];
            [datesCount setObject:nsCount forKey:dateString];
        }
    }
    [self sortMeetingListByDate];
}

- (void) getMeetingLocations{
    [locationsCount removeAllObjects];
    NSNumber *nsCount;
    int incCount;
    Meeting *currMeeting;
    for(int i = 0; i < meetingList.count; i++) {
        currMeeting = meetingList[i];
        if([meetingLocations containsObject:currMeeting.address] == NO){
            [meetingLocations addObject:currMeeting.address];
            [locationsCount setObject:[NSNumber numberWithInt:1] forKey:currMeeting.address];
        }else{
            nsCount = [locationsCount objectForKey:currMeeting.address];
            incCount = [nsCount intValue];
            nsCount = [NSNumber numberWithInt:incCount + 1];
            [locationsCount setObject:nsCount forKey:currMeeting.address];
        }
    }
    [self sortMeetingListByLocation];
}
- (void) sortMeetingListByDate{
    meetingsSortedByDate = [meetingList sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(Meeting*)a date];
        NSDate *second = [(Meeting*)b date];
        return [first compare:second];
    }];
}
- (void) sortMeetingListByLocation{
    meetingsSortedByLocation = [meetingList sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first = [(Meeting*)a address];
        NSString *second = [(Meeting*)b address];
        return [first compare:second];
    }];
}

@end
