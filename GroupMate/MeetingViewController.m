//
//  MeetingViewController.m
//  GroupMate
//
//  Created by K MacDonald on 2014-11-07.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "MeetingViewController.h"
#import "EditViewController.h"
#import "ImageCollectionViewCell.h"
#import "ImageViewController.h"

@interface MeetingViewController ()

@end

@implementation MeetingViewController{
    UIImage *imageToView;
<<<<<<< HEAD
    NSInteger imageToViewIndex;
=======
>>>>>>> 4e655cf12fec726b26d1d6691bf5b09a0efd31e0
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updatePage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"editSegue"]){
        EditViewController *controller = [segue destinationViewController];
        [controller setMeeting:meeting];
        [controller setMeetingList:meetingList];
        [controller setIndex:index];
    }else if ([segue.identifier isEqualToString:@"ViewMeetingViewImage"]){
        ImageViewController *controller = [segue destinationViewController];
        [controller setImage:imageToView];
        [controller setMeetingName:meeting.name];
    }
}

- (void)updatePage{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSDate *date = meeting.date;
    NSString *dateString = [dateFormatter stringFromDate:date];
    [self.dateLabel setText:dateString];
    [self.notesLabel setText:meeting.notes];
    [self.navigationItem setTitle:meeting.name];
    
    [self.imageCollectionView reloadData];
    
    if([meeting.colour  isEqual: @"Red"]){
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
    }else if([meeting.colour  isEqual: @"Orange"]){
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor orangeColor]}];
    }else if([meeting.colour  isEqual: @"Yellow"]){
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor yellowColor]}];
    }else if([meeting.colour  isEqual: @"Green"]){
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor greenColor]}];
    }else if([meeting.colour  isEqual: @"Blue"]){
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
    }else if([meeting.colour  isEqual: @"Purple"]){
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor purpleColor]}];
    }else if([meeting.colour  isEqual: @"Black"]){
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    }
}

- (void) setMeeting:(Meeting*)currMeeting{
    meeting = currMeeting;
}
- (void) setIndex:(int)currIndex{
    index = currIndex;
}
- (void)setMeetingList:(NSMutableArray*) meetingListCopy{
    meetingList = meetingListCopy;
}

- (IBAction)emailMeeting:(id)sender {
    NSString *emailTitle = [NSString stringWithFormat:@"GroupMate Meeting: %@", meeting.name];
    NSString *messageBody = @"Here is a copy of the meeting from GroupMate:";

    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];

    NSData *fileData = [NSKeyedArchiver archivedDataWithRootObject:meeting];
                         
    // Add attachment
    [mc addAttachmentData:fileData mimeType:@"text" fileName:[NSString stringWithFormat:@"%@.mtng", meeting.name]];

    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];

}

- (IBAction)swipeFromEdge:(id)sender {
<<<<<<< HEAD
    NSLog(@"Swiped!");
=======
>>>>>>> 4e655cf12fec726b26d1d6691bf5b09a0efd31e0
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if(result == MFMailComposeResultFailed){
       NSLog(@"Error: %@", [error localizedDescription]);
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)unwindToDisplay:(UIStoryboardSegue *)segue{
    if ([segue.identifier isEqualToString:@"UnwindToDisplay"]) {
        MeetingViewController *controller = [segue destinationViewController];
        
        [controller setMeetingList:meetingList];
    }else if ([segue.identifier isEqualToString:@"UnwindToDisplayFromEdit"]) {
        MeetingViewController *controller = [segue destinationViewController];
        
        [controller setMeetingList:meetingList];
        [controller setMeeting:meeting];
        [controller updatePage];
    }

    [self.imageCollectionView reloadData];
}

#pragma mark - UICollectionView
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [meeting.images count];
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    cell = [cell init];
    
    NSInteger row = indexPath.row;
    [cell.image setImage:[UIImage imageWithData:meeting.images[row]]];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = (ImageCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    imageToView = cell.image.image;
<<<<<<< HEAD
    imageToViewIndex = indexPath.row;
=======
>>>>>>> 4e655cf12fec726b26d1d6691bf5b09a0efd31e0
    [self performSegueWithIdentifier:@"ViewMeetingViewImage" sender:self];
}
@end
