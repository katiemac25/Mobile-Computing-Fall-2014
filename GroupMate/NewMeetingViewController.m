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

@interface NewMeetingViewController ()

@end

@implementation NewMeetingViewController{
    int colourIndex;
    Meeting *newMeeting;
    UIAlertView *alert;
    BOOL cancelConfirmed;
    int imageCount;
    NSString *meetingAddress;
    UIAlertView *deleteAlert;
    
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
    
    imageCount = 0;
    
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
    [[self.notes layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.notes layer] setBorderWidth:1];
    [[self.notes layer] setCornerRadius:5];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    imageView1.clipsToBounds = YES;
    imageView2.clipsToBounds = YES;
    imageView3.clipsToBounds = YES;
    
    deleteAlert = [[UIAlertView alloc] initWithTitle:@"Delete Image"
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
        [newMeeting setAddress:@"No Address"];
    }
    
    //Add new meeting to meeting list
    [meetingList addObject:newMeeting];
    
    [self performSegueWithIdentifier:@"UnwindToList" sender:self];
}

- (void) updateImages{
    imageView1.image = nil;
    imageView2.image = nil;
    imageView3.image = nil;
    
    if(newMeeting.images.count >= 1){
        imageView1.image = [UIImage imageWithData:newMeeting.images[0]];
    }
    
    if(newMeeting.images.count >= 2){
        imageView2.image = [UIImage imageWithData:newMeeting.images[1]];
    }
    
    if(newMeeting.images.count == 3){
        imageView3.image = [UIImage imageWithData:newMeeting.images[2]];
    }
}

- (IBAction)takePhoto:(id)sender {
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
        
        if(imageCount == 0){
            [imageView1 setImage:image];
            imageCount++;
        }else if(imageCount == 1){
            [imageView2 setImage:image];
            imageCount++;
        }else if(imageCount == 2){
            [imageView3 setImage:image];
            imageCount++;
        }
        
        NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
        [newMeeting addImage:imageData];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)deleteImage1:(id)sender{
    deleteAlert.tag = 1;
    [deleteAlert show];
}
- (IBAction)deleteImage2:(id)sender{
    deleteAlert.tag = 2;
    [deleteAlert show];
}
- (IBAction)deleteImage3:(id)sender{
    deleteAlert.tag = 3;
    [deleteAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1 && buttonIndex == 1) {//Delete image 1
        [newMeeting removeImage:0];
        [self updateImages];
    }else if(alertView.tag == 2 && buttonIndex == 1) {//Delete image 2
        [newMeeting removeImage:1];
        [self updateImages];
    }else if(alertView.tag == 3 && buttonIndex == 1) {//Delete image 3
        [newMeeting removeImage:2];
        [self updateImages];
    }else if (buttonIndex == 1) {//Cancel OK
        cancelConfirmed = true;
        [self performSegueWithIdentifier:@"UnwindToList" sender:self];
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

@end
