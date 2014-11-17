//
//  NewMeetingViewController.h
//  GroupMate
//
//  Created by K MacDonald on 2014-10-29.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewMeetingViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    NSMutableArray *meetingList;
    
    IBOutlet UIImageView *imageView;
    UIImagePickerController *picker;
    UIImage *image;
}

@property (weak, nonatomic) IBOutlet UIButton *colourPicker;
@property (weak, nonatomic) IBOutlet UITextView *notes;
@property (weak, nonatomic) IBOutlet UITextField *meetingName;

- (IBAction)updateMeetingName:(id)sender;
- (IBAction)changeColourTag:(id)sender;
- (void)setMeetingList:(NSMutableArray*) meetingListCopy;
- (IBAction)confirmCancel:(id)sender;
- (IBAction)saveMeeting:(id)sender;
- (IBAction)takePhoto:(id)sender;

@end
