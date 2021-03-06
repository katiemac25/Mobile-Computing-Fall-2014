//
//  NewMeetingViewController.h
//  GroupMate
//
//  Created by K MacDonald on 2014-10-29.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>

@interface NewMeetingViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>{
    NSMutableArray *meetingList;
    UIImagePickerController *imagePicker;
    UIImage *image;
}

@property (weak, nonatomic) IBOutlet UIButton *colourPicker;
@property (weak, nonatomic) IBOutlet UITextView *notes;
@property (weak, nonatomic) IBOutlet UITextField *meetingName;
@property (strong, nonatomic) IBOutlet UICollectionView *imageCollectionView;

- (IBAction)updateMeetingName:(id)sender;
- (IBAction)changeColourTag:(id)sender;
- (void)setMeetingList:(NSMutableArray*) meetingListCopy;
- (IBAction)confirmCancel:(id)sender;
- (IBAction)saveMeeting:(id)sender;
- (void)takePhoto;
- (void)attachPhoto;
- (IBAction)addPhoto:(id)sender;

@end
