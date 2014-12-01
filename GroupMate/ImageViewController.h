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
<<<<<<< HEAD
    NSInteger imageIndex;
=======
>>>>>>> 4e655cf12fec726b26d1d6691bf5b09a0efd31e0
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (void) setImage:(UIImage*)currImage;
- (void) setMeetingName:(NSString*)currName;
<<<<<<< HEAD
- (void) setImageIndex:(NSInteger)index;
- (IBAction)share:(id)sender;
- (IBAction)deleteImage:(id)sender;
=======
>>>>>>> 4e655cf12fec726b26d1d6691bf5b09a0efd31e0

@end
