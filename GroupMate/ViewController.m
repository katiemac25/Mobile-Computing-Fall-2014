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
    NSArray *meetingsSortedByDate, *meetingsSortedByLocation, *alphabeticalLocations;
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: viewDidLoad
 PURPOSE: Set up view
 ******************************************************************************
 ******************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Allocate space for master meeting list
    meetingList = [[NSMutableArray alloc] init];
    
    currMeetingIndex = -1;
    
    //Initially set screen to sort by date
    sortByDate = true;
    
    //Allocate space to items used for sorting by date & location
    meetingDates = [[NSMutableArray alloc] init];
    meetingLocations =[[NSMutableArray alloc] init];
    datesCount = [[NSMutableDictionary alloc] init];
    locationsCount = [[NSMutableDictionary alloc] init];
    
    //Get meetings saved to file
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docsPath stringByAppendingPathComponent:@"meetingList"];
    meetingList = [[NSKeyedUnarchiver unarchiveObjectWithFile:filePath] mutableCopy];
    if([meetingList count] > 0){
        [self getMeetingDates];
        [self getMeetingLocations];
    }
    
    //Remove warning about ambiguous row height
    self.meetingListTable.rowHeight = 44;
    
    //Add '+' button to UIBarButton to create new meeting
    UIBarButtonItem *newMeeting = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(addMeeting)];
    
    [self.navigationItem setRightBarButtonItem:newMeeting];
}
/******************************************************************************
 ******************************************************************************
 FUNCTION: didReceiveMemoryWarning
 ******************************************************************************
 ******************************************************************************/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: numberOfSectionsInTableView:
 PURPOSE: Return the number of sections in table depending on whether sort by 
 date or sort by location is being displayed
 ******************************************************************************
 ******************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(sortByDate){
        return meetingDates.count;
    }else{
        return meetingLocations.count;
    }
}
/******************************************************************************
 ******************************************************************************
 FUNCTION: tableView:numberOfRowsInSection
 PURPOSE: Return the number of sections in table depending on whether sort by
 date or sort by location is being displayed
 ******************************************************************************
 ******************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the sections in table depending on whether
    // sort by date or sort by location is being displayed
    NSString *sectionHeader;
    NSNumber *nsCount;
    
    if(sortByDate){
        // Get name of section from meetingDates
        sectionHeader = meetingDates[section];
        
        // Get number of meetings that fall under that date
        nsCount = [datesCount objectForKey:sectionHeader];
        
        // Convert number to an int & return
        return [nsCount intValue];
    }else{
        // Get name of section from alphabeticalLocations
        sectionHeader = alphabeticalLocations[section];
        
        // Get number of meetings that fall under that location
        nsCount = [locationsCount objectForKey:sectionHeader];
        
        // Convert number to an int & return
        return [nsCount intValue];
    }
}
/******************************************************************************
 ******************************************************************************
 FUNCTION: tableView:titleForHeaderInSection
 PURPOSE: Return name of section
 ******************************************************************************
 ******************************************************************************/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(sortByDate){
        return meetingDates[section];
    }else{
        return alphabeticalLocations[section];
    }
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: tableView:cellForRowAtIndexPath
 PURPOSE: Populate table view
 ******************************************************************************
 ******************************************************************************/
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
            sectionHeader = meetingDates[section - 1];
            nsCount = [datesCount objectForKey:sectionHeader];
            index += [nsCount intValue];
        }
        index += row;
        currMeeting = (Meeting*)[meetingsSortedByDate objectAtIndex:index];
    }else{
        //NSLog(@"location");
        index = 0;
        //NSLog(@"Section %lu, Row: %lu", section, (unsigned long)row);
        for(int i = 0; i < section; i++){
            sectionHeader = alphabeticalLocations[section - 1];
           // NSLog(@"Section Header: %@", sectionHeader);
            nsCount = [locationsCount objectForKey:sectionHeader];
            //NSLog(@"locationsCount: %@", nsCount);
            index += [nsCount intValue];
        }
        index += row;
        currMeeting = (Meeting*)[meetingsSortedByLocation objectAtIndex:index];
        //NSLog(@"Index: %lu", (unsigned long)index);
        //NSLog(@"meetingsSortedByLocation: %@", currMeeting.name);
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
    //currMeetingIndex = indexPath.row;
    
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSUInteger index = 0;
    NSString *sectionHeader;
    NSNumber *nsCount;
    
    if(sortByDate){
        for(int i = 0; i < section; i++){
            sectionHeader = meetingDates[section - 1];
            nsCount = [datesCount objectForKey:sectionHeader];
            index += [nsCount intValue];
        }
        index += row;
    }else{
        for(int i = 0; i < section; i++){
            sectionHeader = alphabeticalLocations[section - 1];
            nsCount = [locationsCount objectForKey:sectionHeader];
            index += [nsCount intValue];
        }
        index += row;
    }
    currMeetingIndex = index;
    
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
    [self saveToFile];
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
    [meetingDates removeAllObjects];
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
    //NSLog(@"getMeetingLocations");
    [meetingLocations removeAllObjects];
    [locationsCount removeAllObjects];
    
    NSNumber *nsCount;
    int incCount;
    Meeting *currMeeting;
    for(int i = 0; i < meetingList.count; i++) {
        currMeeting = meetingList[i];
        if([meetingLocations containsObject:currMeeting.address] == NO){
            [meetingLocations addObject:currMeeting.address];
            //NSLog(@"%@", meetingLocations);
            [locationsCount setObject:[NSNumber numberWithInt:1] forKey:currMeeting.address];
            //NSLog(@"%@", locationsCount);
        }else{
            nsCount = [locationsCount objectForKey:currMeeting.address];
            incCount = [nsCount intValue];
            nsCount = [NSNumber numberWithInt:incCount + 1];
            [locationsCount setObject:nsCount forKey:currMeeting.address];
            //NSLog(@"%@", locationsCount);
        }
    }
    [self sortMeetingListByLocation];
}
- (void) sortMeetingListByDate{
    meetingsSortedByDate = [meetingList sortedArrayUsingComparator:^NSComparisonResult(id meetingA, id meetingB) {
        NSDate *firstMeeting = [(Meeting*)meetingA date];
        NSDate *secondMeeting = [(Meeting*)meetingB date];
        return [firstMeeting compare:secondMeeting];
    }];
}
- (void) sortMeetingListByLocation{
    meetingsSortedByLocation = [meetingList sortedArrayUsingComparator:^NSComparisonResult(id meetingA, id meetingB) {
        NSString *firstMeeting = [(Meeting*)meetingA address];
        NSString *secondMeeting = [(Meeting*)meetingB address];
        return [firstMeeting compare:secondMeeting];
    }];
    
    alphabeticalLocations = [[locationsCount allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

- (void) viewWillDisappear:(BOOL)animated{
    [self saveToFile];
}

- (void) saveToFile{
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docsPath stringByAppendingPathComponent:@"meetingList"];
    
    [NSKeyedArchiver archiveRootObject:meetingList toFile:filePath];
}

@end
