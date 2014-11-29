//
//  EditViewController.m
//  GroupMate
//
//  Created by K MacDonald on 2014-11-09.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "EditViewController.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Meeting.h"
#import "ImageCollectionViewCell.h"

@interface EditViewController ()

@end

@implementation EditViewController{
    int colourIndex;
    Meeting *newMeeting;
    UIAlertView *deleteImageAlert, *deleteMeetingAlert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.meetingName.delegate = self;
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    [[self.notes layer] setBorderColor:[[UIColor colorWithRed:226.0f/255.0f
                                                        green:226.0f/255.0f
                                                         blue:226.0f/255.0f
                                                        alpha:1.0f] CGColor]];
    [[self.notes layer] setBorderWidth:1];
    [[self.notes layer] setCornerRadius:5];
    
    [self.navigationItem setTitle:meeting.name];
    [self.meetingName setText:meeting.name];
    
    [self.notes setText:meeting.notes];
    [self.imageCollectionView reloadData];
    
    if([meeting.colour  isEqual: @"Red"]){
        [self.colourPicker setBackgroundColor:[UIColor redColor]];
        colourIndex = 0;
    }else if([meeting.colour  isEqual: @"Orange"]){
        [self.colourPicker setBackgroundColor:[UIColor orangeColor]];
        colourIndex = 1;
    }else if([meeting.colour  isEqual: @"Yellow"]){
        [self.colourPicker setBackgroundColor:[UIColor yellowColor]];
        colourIndex = 2;
    }else if([meeting.colour  isEqual: @"Green"]){
        [self.colourPicker setBackgroundColor:[UIColor greenColor]];
        colourIndex = 3;
    }else if([meeting.colour  isEqual: @"Blue"]){
        [self.colourPicker setBackgroundColor:[UIColor blueColor]];
        colourIndex = 4;
    }else if([meeting.colour  isEqual: @"Purple"]){
        [self.colourPicker setBackgroundColor:[UIColor purpleColor]];
        colourIndex = 5;
    }else if([meeting.colour  isEqual: @"Black"]){
        [self.colourPicker setBackgroundColor:[UIColor blackColor]];
        colourIndex = 6;
    }
    
    deleteImageAlert = [[UIAlertView alloc] initWithTitle:@"Delete Image"
                                             message:@"Are you sure you want to delete this image?"
                                            delegate:self
                                   cancelButtonTitle:@"Cancel"
                                   otherButtonTitles:@"OK", nil];
    deleteMeetingAlert = [[UIAlertView alloc] initWithTitle:@"Delete Meeting"
                                                    message:@"Are you sure you want to delete this meeting?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) setMeeting:(Meeting*)currMeeting{
    meeting = currMeeting;
    newMeeting = currMeeting;
}
- (void) setIndex:(int)currIndex{
    index = currIndex;
}
- (void)setMeetingList:(NSMutableArray*) meetingListCopy{
    meetingList = meetingListCopy;
}

- (IBAction)saveMeeting:(id)sender {
    if(![self.meetingName.text  isEqual: @""]){
        [newMeeting setName:self.meetingName.text];
    }else{
        //If user has not created a custom meeting name, make meeting name
        //the date and time of the meeting
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        NSDate *date = [NSDate date];
        NSString *dateString = [dateFormatter stringFromDate:date];
        NSString *meetingTitle = [NSString stringWithFormat:@"%@", dateString];
        [newMeeting setName:meetingTitle];
    }
    [newMeeting setNotes:self.notes.text];
    meeting = newMeeting;
    [meetingList replaceObjectAtIndex:index withObject:meeting];
    [self performSegueWithIdentifier:@"UnwindToDisplayFromEdit" sender:self];
}

- (IBAction)changeColourTag:(id)sender {
    if(colourIndex == 0){
        [self.colourPicker setBackgroundColor:[UIColor orangeColor]];
        [newMeeting setColour:@"Orange"];
        colourIndex++;
    }else if(colourIndex == 1){
        [self.colourPicker setBackgroundColor:[UIColor yellowColor]];
        [newMeeting setColour:@"Yellow"];
        colourIndex++;
    }else if(colourIndex == 2){
        [self.colourPicker setBackgroundColor:[UIColor greenColor]];
        [newMeeting setColour:@"Green"];
        colourIndex++;
    }else if(colourIndex == 3){
        [self.colourPicker setBackgroundColor:[UIColor blueColor]];
        [newMeeting setColour:@"Blue"];
        colourIndex++;
    }else if(colourIndex == 4){
        [self.colourPicker setBackgroundColor:[UIColor purpleColor]];
        [newMeeting setColour:@"Purple"];
        colourIndex++;
    }else if(colourIndex == 5){
        [self.colourPicker setBackgroundColor:[UIColor blackColor]];
        [newMeeting setColour:@"Black"];
        colourIndex++;
    }else if(colourIndex == 6){
        [self.colourPicker setBackgroundColor:[UIColor redColor]];
        [newMeeting setColour:@"Red"];
        colourIndex = 0;
    }
}

- (IBAction)updateMeetingName:(id)sender {
    if(![self.meetingName.text  isEqual: @""]){
        [self.navigationItem setTitle:self.meetingName.text];
    }else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        NSDate *date = [NSDate date];
        NSString *dateString = [dateFormatter stringFromDate:date];
        NSString *meetingTitle = [NSString stringWithFormat:@"%@", dateString];
        NSLog(@"%@", meetingTitle);
        
        [self.navigationItem setTitle:meetingTitle];
    }
}

- (IBAction)deleteMeeting:(id)sender {
    [deleteMeetingAlert show];
    deleteMeetingAlert.tag = -2;
}

- (IBAction)addPhoto:(id)sender {
    UIActionSheet *cameraOrRoll = [[UIActionSheet alloc] initWithTitle:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"Take Photo/Video",
                                   @"Add From Camera Roll",
                                   nil];
    [cameraOrRoll showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        [self takePhoto];
    }else if(buttonIndex == 1){
        [self attachPhoto];
    }
}

- (void)takePhoto{
    BOOL hasCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (hasCamera == NO){
        UIAlertView *cameraAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Camera Unavailable"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                                    otherButtonTitles:nil, nil];
        [cameraAlert show];
        return;
    }
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    imagePicker.mediaTypes = [UIImagePickerController
                              availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (void)attachPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if(CFStringCompare((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo){
        NSString *moviePath = (NSString *) [[info objectForKey: UIImagePickerControllerMediaURL] path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)){
            UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil, nil, nil);
        }
    }else{
        image = [info objectForKey:UIImagePickerControllerEditedImage];
        //UIImageWriteToSavedPhotosAlbum (image, nil, nil , nil);
        
        [self.imageCollectionView reloadData];
        
        NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
        [newMeeting addImage:imageData];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == -2 && buttonIndex == 1){
        [meetingList removeObjectAtIndex:index];
        [self performSegueWithIdentifier:@"UnwindToListFromEdit" sender:self];
    }else if(buttonIndex == 1){
        [newMeeting removeImage:alertView.tag];
        [self.imageCollectionView reloadData];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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

@end
