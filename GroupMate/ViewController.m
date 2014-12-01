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
    BOOL sortByDate, searchEnabled;
    NSMutableArray *meetingDates, *meetingLocations;
    NSMutableDictionary *datesCount, *locationsCount;
    NSArray *meetingsSortedByDate, *meetingsSortedByLocation, *alphabeticalLocations;
    NSMutableArray *searchResults;
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: viewDidLoad
 PURPOSE: Set up view
 ******************************************************************************
 ******************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    currMeetingIndex = -1;
    
    //Initially set screen to sort by date
    sortByDate = true;
    
    searchEnabled = false;
    
    //Allocate space to items used for sorting by date & location
    meetingDates = [[NSMutableArray alloc] init];
    meetingLocations =[[NSMutableArray alloc] init];
    datesCount = [[NSMutableDictionary alloc] init];
    locationsCount = [[NSMutableDictionary alloc] init];
    
    //Allocate space for search results
    searchResults = [[NSMutableArray alloc] init];
    
    //Get meetings saved to file
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docsPath stringByAppendingPathComponent:@"meetingList"];
    meetingList = [[NSKeyedUnarchiver unarchiveObjectWithFile:filePath] mutableCopy];
    if([meetingList count] > 0){
        [self getMeetingDates];
        [self getMeetingLocations];
    }else{
        //Allocate space for master meeting list
        meetingList = [[NSMutableArray alloc] init];
    }
    
    //Remove warning about ambiguous row height
    self.meetingListTable.rowHeight = 44;
    
    //Add '+' button to UIBarButton to create new meeting
    UIBarButtonItem *newMeeting = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(newMeeting)];
    
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
    if (searchEnabled) {
        return 1;
    }else if(sortByDate){
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
    
    if (searchEnabled) {
        return [searchResults count];
    }else if(sortByDate){
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
    if (searchEnabled) {
        return @"Search Results";
    }else if(sortByDate){
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
    static NSString *CellIdentifier = @"MeetingCell";
    
    //Use custom MeetingCell
    MeetingTableViewCell *cell = (MeetingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[MeetingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //Get the current section & row
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    //Declare other variables
    Meeting *currMeeting;
    NSUInteger index;
    NSString *sectionHeader;
    NSNumber *nsCount;
    
    //Calculate the row number by determining how many rows were in the
    //previous sections
    if (searchEnabled) {
        currMeeting = (Meeting*)[searchResults objectAtIndex:row];
    }else if(sortByDate){
        index = 0;
        //For each previous section...
        for(int i = 0; i < section; i++){
            //Get the section header
            sectionHeader = meetingDates[i];
            
            //Get the number of meeting under that section
            nsCount = [datesCount objectForKey:sectionHeader];
            
            //Add the number of meetings to the index
            index += [nsCount intValue];
        }
        //Add the row in the current section to the index
        index += row;
        
        //Get meeting at calculated index from meetingsSortedByDate
        currMeeting = (Meeting*)[meetingsSortedByDate objectAtIndex:index];
    }else{
        index = 0;
        //For each previous section...
        for(int i = 0; i < section; i++){
            //Get the section header
            sectionHeader = alphabeticalLocations[i];
            
            //Get the number of meeting under that section
            nsCount = [locationsCount objectForKey:sectionHeader];
            
            //Add the number of meetings to the index
            index += [nsCount intValue];
        }
        //Add the row in the current section to the index
        index += row;
        //Get meeting at calculated index from meetingsSortedByLocation
        currMeeting = (Meeting*)[meetingsSortedByLocation objectAtIndex:index];
    }
    
    //Set colour tag of cell
    if([currMeeting.colour isEqual: @"Red"]){
        cell.colour.backgroundColor = [UIColor redColor];
    }else if([currMeeting.colour isEqual: @"Orange"]){
        cell.colour.backgroundColor = [UIColor orangeColor];
    }else if([currMeeting.colour isEqual: @"Yellow"]){
        cell.colour.backgroundColor = [UIColor yellowColor];
    }else if([currMeeting.colour isEqual: @"Green"]){
        cell.colour.backgroundColor = [UIColor greenColor];
    }else if([currMeeting.colour isEqual: @"Blue"]){
        cell.colour.backgroundColor = [UIColor blueColor];
    }else if([currMeeting.colour isEqual: @"Purple"]){
        cell.colour.backgroundColor = [UIColor purpleColor];
    }else if([currMeeting.colour isEqual: @"Black"]){
        cell.colour.backgroundColor = [UIColor blackColor];
    }
    
    //Set name of cell
    cell.title.text = currMeeting.name;

    return cell;
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: tableView:didSelectRowAtIndexPath
 PURPOSE: Handles user selecting a meeting
 ******************************************************************************
 ******************************************************************************/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSUInteger index = 0;
    NSString *sectionHeader;
    NSNumber *nsCount;
    Meeting *selectedMeeting;
    
    
    if(searchEnabled){
        selectedMeeting = (Meeting*)[searchResults objectAtIndex:row];
    }else if(sortByDate){
        //Calculate the row number by determining how many rows were in the
        //previous sections
        for(int i = 0; i < section; i++){
            sectionHeader = meetingDates[i];
            nsCount = [datesCount objectForKey:sectionHeader];
            index += [nsCount intValue];
        }
        index += row;
        selectedMeeting = (Meeting*)[meetingsSortedByDate objectAtIndex:index];
    }else{
        //Calculate the row number by determining how many rows were in the
        //previous sections
        for(int i = 0; i < section; i++){
            sectionHeader = alphabeticalLocations[i];
            nsCount = [locationsCount objectForKey:sectionHeader];
            index += [nsCount intValue];
        }
        index += row;
        selectedMeeting = (Meeting*)[meetingsSortedByLocation objectAtIndex:index];
    }
    
    //Find selectedMeeting in meetingList, and save index so that it can be
    //passed during prepareForSegue
    for(int i = 0; i < meetingList.count; i++){
        if(selectedMeeting == meetingList[i]){
            currMeetingIndex = i;
            break;
        }
    }
    
    //Segue to view meeting
    [self performSegueWithIdentifier:@"viewMeetingSegue"sender:self];
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: newMeeting
 PURPOSE: Segues to new meeting view
 ******************************************************************************
 ******************************************************************************/
-(void) newMeeting{
    [self performSegueWithIdentifier:@"newMeetingSegue"sender:self];
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: prepareForSegue:sender
 PURPOSE: Performs actions that need to be done before segue happens, such as
 passing objects to the destinationViewController
 ******************************************************************************
 ******************************************************************************/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //Take certain actions depending on the segue being called
    if ([segue.identifier isEqualToString:@"newMeetingSegue"]) {
        //If newMeetingSegue is called, pass meetingList to
        //destinationViewController
        NewMeetingViewController *controller = [segue destinationViewController];
        [controller setMeetingList:meetingList];
    }else if ([segue.identifier isEqualToString:@"viewMeetingSegue"]){
        //If viewMeetingSegue is called, pass meetingList, selected meeting, &
        //currMeetingIndex to destinationViewController
        MeetingViewController *controller = [segue destinationViewController];
        
        [controller setMeeting:(Meeting*)[meetingList objectAtIndex:currMeetingIndex]];
        
        [controller setMeetingList:meetingList];
        [controller setIndex:(int)currMeetingIndex];
    }
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: unwindToList
 PURPOSE: Performs actions that need to be done when unwinding to this view
 ******************************************************************************
 ******************************************************************************/
- (IBAction)unwindToList:(UIStoryboardSegue *)segue{
    //Get meeting list from destinationViewController
    ViewController *controller = [segue destinationViewController];
    [controller setMeetingList:meetingList];
    
    //Reset navigation bar to black
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    //Update data in case changes were made
    [self getMeetingDates];
    [self getMeetingLocations];
    
    //Save data in case changes were made
    [self saveToFile];
    
    //Refresh table
    [self.meetingListTable reloadData];
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: setMeetingList
 PURPOSE: Set the meetingList
 ******************************************************************************
 ******************************************************************************/
- (void)setMeetingList:(NSMutableArray*) meetingListCopy{
    meetingList = meetingListCopy;
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: sortTable
 PURPOSE: Determine how to sort the table when user selects Date or Location 
 from segmented control
 ******************************************************************************
 ******************************************************************************/
- (IBAction)sortTable:(id)sender {
    if(self.dateOrLocation.selectedSegmentIndex == 0){
        //Sort by date
        sortByDate = true;
    }else{
        //Sort by location
        sortByDate = false;
    }
    
    //Refresh table
    [self.meetingListTable reloadData];
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: search
 PURPOSE: Parse through meetingList & create a new array of search results to be
 displayed in table
 ******************************************************************************
 ******************************************************************************/
- (IBAction)search:(id)sender {
    NSString *searchText = self.searchTextField.text;
    
    [searchResults removeAllObjects];
    
    if ([searchText  isEqual: @""]) {
        searchEnabled = false;
    }else{
        searchEnabled = true;
        Meeting *currMeeting;
        for(int i = 0; i < meetingList.count; i++){
            currMeeting = meetingList[i];
            if([[currMeeting.name lowercaseString] containsString:[searchText lowercaseString]]){
                [searchResults addObject:currMeeting];
            }else if ([[currMeeting.notes lowercaseString] containsString:[searchText lowercaseString]]){
                [searchResults addObject:currMeeting];
            }else if ([[currMeeting.address lowercaseString] containsString:[searchText lowercaseString]]){
                [searchResults addObject:currMeeting];
            }else if ([[currMeeting.colour lowercaseString] containsString:[searchText lowercaseString]]){
                [searchResults addObject:currMeeting];
            }
        }
    }
    [self.meetingListTable reloadData];
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: getMeetingDates
 PURPOSE: 
    - Parse through meetingList and determine how many different dates there 
      are
    - Save the different dates to  meetingDates so that they can be used as 
      section headers for the table
    - Keep track of how many meetings fall under each date & store this info in
      datesCount
 ******************************************************************************
 ******************************************************************************/
- (void) getMeetingDates{
    //Clear previous data
    [meetingDates removeAllObjects];
    [datesCount removeAllObjects];
    
    NSNumber *nsCount;
    int incCount;
    Meeting *currMeeting;
    
    for(int i = 0; i < meetingList.count; i++) {
        //Get the current meeting & its date
        currMeeting = meetingList[i];
        NSDate *currDate = currMeeting.date;
        
        //Format date (MMM. DD, YYYY)
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        NSString *dateString = [dateFormatter stringFromDate:currDate];
        
        //Check if date is already in meetingDates
        if([meetingDates containsObject:dateString] == NO){
            //If the date is not already in meetingDates, add it
            [meetingDates addObject:dateString];
            
            //Set number of meetings with this date to 1
            [datesCount setObject:[NSNumber numberWithInt:1] forKey:dateString];
        }else{
            //If the date is already in meetingDates, increment datesCount for
            //that date by 1
            nsCount = [datesCount objectForKey:dateString];
            incCount = [nsCount intValue];
            nsCount = [NSNumber numberWithInt:incCount + 1];
            [datesCount setObject:nsCount forKey:dateString];
        }
    }
    
    //Call sortMeetingListByDate
    [self sortMeetingListByDate];
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: getMeetingLocations
 PURPOSE:
     - Parse through meetingList and determine how many different locations 
       there are
     - Save the different dates to  meetingLocations so that they can be used as
       section headers for the table
     - Keep track of how many meetings fall under each location & store this 
       info in locationsCount
 ******************************************************************************
 ******************************************************************************/
- (void) getMeetingLocations{
    //Clear previous data
    [meetingLocations removeAllObjects];
    [locationsCount removeAllObjects];
    
    NSNumber *nsCount;
    int incCount;
    Meeting *currMeeting;
    
    for(int i = 0; i < meetingList.count; i++) {
        //Get the current meeting
        currMeeting = meetingList[i];
        
        //Check if location is already in meetingLocations
        if([meetingLocations containsObject:currMeeting.address] == NO){
            //If the location is not already in meetingDates, add it
            [meetingLocations addObject:currMeeting.address];
            
            //Set number of meetings with this location to 1
            [locationsCount setObject:[NSNumber numberWithInt:1] forKey:currMeeting.address];
        }else{
            //If the date is already in meetingLocations, increment datesCount
            //for that date by 1
            nsCount = [locationsCount objectForKey:currMeeting.address];
            incCount = [nsCount intValue];
            nsCount = [NSNumber numberWithInt:incCount + 1];
            [locationsCount setObject:nsCount forKey:currMeeting.address];
        }
    }
    //Call sortMeetingListByLocation
    [self sortMeetingListByLocation];
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: sortMeetingListByDate
 PURPOSE: Sort the meetings by date in meetingsSortedByDate so that they can be 
 called in the correct order
 ******************************************************************************
 ******************************************************************************/
- (void) sortMeetingListByDate{
    meetingsSortedByDate = [meetingList sortedArrayUsingComparator:^NSComparisonResult(id meetingA, id meetingB) {
        NSDate *firstMeeting = [(Meeting*)meetingA date];
        NSDate *secondMeeting = [(Meeting*)meetingB date];
        return [firstMeeting compare:secondMeeting];
    }];
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: sortMeetingListByLocation
 PURPOSE: Sort the meetings alphabetically by location in
 meetingsSortedByLocation so that they can be called in the correct order
 ******************************************************************************
 ******************************************************************************/
- (void) sortMeetingListByLocation{
    meetingsSortedByLocation = [meetingList sortedArrayUsingComparator:^NSComparisonResult(id meetingA, id meetingB) {
        NSString *firstMeeting = [(Meeting*)meetingA address];
        NSString *secondMeeting = [(Meeting*)meetingB address];
        return [firstMeeting compare:secondMeeting];
    }];
    
    //Create an alternate array to hold the section names that is sorted
    //alphabetically (prevents meetings from being put under wrong section in
    //the table)
    alphabeticalLocations = [[locationsCount allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: saveToFile
 PURPOSE: Save meetingList to file so that it can be recalled between sessions
 ******************************************************************************
 ******************************************************************************/
- (void) saveToFile{
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docsPath stringByAppendingPathComponent:@"meetingList"];
    
    [NSKeyedArchiver archiveRootObject:meetingList toFile:filePath];
}

/******************************************************************************
 ******************************************************************************
 FUNCTION: saveToFile
 PURPOSE: Save meetingList to file so that it can be recalled between sessions
 ******************************************************************************
 ******************************************************************************/
- (void)handleOpenURL:(NSURL *)url {
    Meeting *meetingFromEmail = [[Meeting alloc] init];
    meetingFromEmail = [meetingFromEmail importFromURL:url];
    if(meetingFromEmail.name != nil){
        [meetingList addObject:meetingFromEmail];
        //Refresh table
        [self.meetingListTable reloadData];
    }
}

@end
