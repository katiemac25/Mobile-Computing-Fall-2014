//
//  EditViewController.h
//  GroupMate
//
//  Created by K MacDonald on 2014-11-09.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meeting.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface EditViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIDocumentInteractionControllerDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>{
    NSMutableArray *meetingList;
    Meeting *meeting;
    int index;
    
    UIImagePickerController *imagePicker;
    UIImage *image;
}

@property (weak, nonatomic) IBOutlet UIButton *colourPicker;
@property (weak, nonatomic) IBOutlet UITextField *meetingName;
@property (weak, nonatomic) IBOutlet UITextView *notes;
@property (strong, nonatomic) IBOutlet UIImageView *image1;
@property (strong, nonatomic) IBOutlet UIImageView *image2;
@property (strong, nonatomic) IBOutlet UIImageView *image3;

- (void) setMeeting:(Meeting*)currMeeting;
- (void) setIndex:(int)currIndex;
- (IBAction)updateMeetingName:(id)sender;
- (IBAction)deleteMeeting:(id)sender;
- (void)setMeetingList:(NSMutableArray*) meetingListCopy;
- (IBAction)saveMeeting:(id)sender;
- (IBAction)changeColourTag:(id)sender;
- (IBAction)deleteImage1:(id)sender;
- (IBAction)deleteImage2:(id)sender;
- (IBAction)deleteImage3:(id)sender;
- (IBAction)addPhoto:(id)sender;

@end
