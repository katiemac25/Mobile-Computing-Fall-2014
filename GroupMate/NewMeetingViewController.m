//
//  NewMeetingViewController.m
//  GroupMate
//
//  Created by K MacDonald on 2014-10-29.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "NewMeetingViewController.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Meeting.h"
#import <CoreLocation/CoreLocation.h>
#import "ImageCollectionViewCell.h"
#import "ImageViewController.h"

@interface NewMeetingViewController ()

@end

@implementation NewMeetingViewController{
    int colourIndex;
    Meeting *newMeeting;
    UIAlertView *alert;
    BOOL cancelConfirmed;
    NSString *meetingAddress;
    UIAlertView *deleteImageAlert;
    UIImage *imageToView;
    
    //Location variables
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.meetingName.delegate = self;
    
    newMeeting = [[Meeting alloc] init];
    
    cancelConfirmed = false;
    
    
    //Get date and time when meeting starts
    [newMeeting setDate:[NSDate date]];
    
    //Location
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 20;
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    
    colourIndex = 0;
    [[self.notes layer] setBorderColor:[[UIColor colorWithRed:226.0f/255.0f
                                                        green:226.0f/255.0f
                                                         blue:226.0f/255.0f
                                                        alpha:1.0f] CGColor]];
    [[self.notes layer] setBorderWidth:1];
    [[self.notes layer] setCornerRadius:5];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    deleteImageAlert = [[UIAlertView alloc] initWithTitle:@"Delete Image"
                                             message:@"Are you sure you want to delete this image?"
                                            delegate:self
                                   cancelButtonTitle:@"Cancel"
                                   otherButtonTitles:@"OK", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateMeetingName:(id)sender {
    if(![self.meetingName.text  isEqual: @""]){
        [self.navigationItem setTitle:self.meetingName.text];
    }else{
        [self.navigationItem setTitle:@"New Meeting"];
    }
}

- (IBAction)changeColourTag:(id)sender {
    if(colourIndex == 0){
        [self.colourPicker setBackgroundColor:[UIColor orangeColor]];
        colourIndex++;
    }else if(colourIndex == 1){
        [self.colourPicker setBackgroundColor:[UIColor yellowColor]];
        colourIndex++;
    }else if(colourIndex == 2){
        [self.colourPicker setBackgroundColor:[UIColor greenColor]];
        colourIndex++;
    }else if(colourIndex == 3){
        [self.colourPicker setBackgroundColor:[UIColor blueColor]];
        colourIndex++;
    }else if(colourIndex == 4){
        [self.colourPicker setBackgroundColor:[UIColor purpleColor]];
        colourIndex++;
    }else if(colourIndex == 5){
        [self.colourPicker setBackgroundColor:[UIColor blackColor]];
        colourIndex++;
    }else if(colourIndex == 6){
        [self.colourPicker setBackgroundColor:[UIColor redColor]];
        colourIndex = 0;
    }
}
- (void)setMeetingList:(NSMutableArray*) meetingListCopy{
    meetingList = meetingListCopy;
}

- (IBAction)confirmCancel:(id)sender {
    alert = [[UIAlertView alloc]
             initWithTitle:@"Are you sure you wish to cancel?"
             message:@"Your meeting will not be saved"
             delegate:self
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@"Ok",
             nil];
    alert.tag = -1;
    [alert show];
}

- (IBAction)saveMeeting:(id)sender {
    //Get meeting name
    if(![self.meetingName.text  isEqual: @""]){
        //If user has created a cutom meeting name, use it
        [newMeeting setName:self.meetingName.text];
    }else{
        //If user has not created a custom meeting name, make meeting name
        //the date and time of the meeting
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        NSString *dateString = [dateFormatter stringFromDate:newMeeting.date];
        NSString *meetingTitle = [NSString stringWithFormat:@"%@", dateString];
        [newMeeting setName:meetingTitle];
    }
    
    //Convert colourIndex into string representation of colour
    if(colourIndex == 0){
        [newMeeting setColour:@"Red"];
    }else if(colourIndex == 1){
        [newMeeting setColour:@"Orange"];
    }else if(colourIndex == 2){
        [newMeeting setColour:@"Yellow"];
    }else if(colourIndex == 3){
        [newMeeting setColour:@"Green"];
    }else if(colourIndex == 4){
        [newMeeting setColour:@"Blue"];
    }else if(colourIndex == 5){
        [newMeeting setColour:@"Purple"];
    }else if(colourIndex == 6){
        [newMeeting setColour:@"Black"];
    }
    
    //set meeting notes
    [newMeeting setNotes:self.notes.text];
    
    //set meeting address
    if(meetingAddress != nil){
        [newMeeting setAddress:meetingAddress];
        NSLog(@"%@", meetingAddress);
    }else{
        [newMeeting setAddress:@"No Location"];
    }
    
    //Add new meeting to meeting list
    [meetingList addObject:newMeeting];
    
    [self performSegueWithIdentifier:@"UnwindToList" sender:self];
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
        
        NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
        [newMeeting addImage:imageData];
        [self.imageCollectionView reloadData];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == -1 && buttonIndex == 1) {//Cancel OK
        cancelConfirmed = true;
        [self performSegueWithIdentifier:@"UnwindToList" sender:self];
    }else{//Delete image
        [newMeeting removeImage:alertView.tag];
        [self.imageCollectionView reloadData];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"UnwindToList"]){
        if (cancelConfirmed == true) {
            return true;
        }else{
            return false;
        }
    }
    return true;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"NewMeetingImageView"]){
        ImageViewController *controller = [segue destinationViewController];
        [controller setImage:imageToView];
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currLocation = [locations lastObject];
    
    [geocoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            meetingAddress = [NSString stringWithFormat:@"%@, %@, %@",
                                 placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country];
        }
    }];
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
    return [newMeeting.images count];
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    cell = [cell init];
    
    NSInteger row = indexPath.row;
    
    [cell.image setImage:[UIImage imageWithData:newMeeting.images[row]]];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = (ImageCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    imageToView = cell.image.image;
    [self performSegueWithIdentifier:@"NewMeetingImageView" sender:self];
}
@end
