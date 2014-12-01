//
//  ImageViewController.h
//  GroupMate
//
//  Created by K MacDonald on 2014-11-29.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface ImageViewController : ViewController{
    UIImage *image;
    NSString *meetingName;
    NSInteger imageIndex;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (void) setImage:(UIImage*)currImage;
- (void) setMeetingName:(NSString*)currName;
- (void) setImageIndex:(NSInteger)index;
- (IBAction)share:(id)sender;
- (IBAction)deleteImage:(id)sender;

@end
