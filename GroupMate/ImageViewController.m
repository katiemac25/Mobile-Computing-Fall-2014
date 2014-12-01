//
//  ImageViewController.m
//  GroupMate
//
//  Created by K MacDonald on 2014-11-29.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.imageView setImage:image];
    
<<<<<<< HEAD
    [self.navigationItem setRightBarButtonItem:nil];
=======
    //Add share button to UIBarButton to create new meeting
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                target:self
                                                                                action:@selector(shareImage)];
    
    [self.navigationItem setRightBarButtonItem:share];
>>>>>>> 4e655cf12fec726b26d1d6691bf5b09a0efd31e0
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) setImage:(UIImage*)currImage{
    image = currImage;
}
- (void) setMeetingName:(NSString *)currName{
    meetingName = currName;
}
<<<<<<< HEAD
- (void) setImageIndex:(NSInteger)index{
    imageIndex = index;
}

- (IBAction)share:(id)sender {
=======

- (void) shareImage{
>>>>>>> 4e655cf12fec726b26d1d6691bf5b09a0efd31e0
    UIActionSheet *selectSocialMedia = [[UIActionSheet alloc] initWithTitle:nil
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                     destructiveButtonTitle:nil
                                                          otherButtonTitles:@"Facebook",
<<<<<<< HEAD
                                        @"Twitter",
=======
                                                                            @"Twitter",
>>>>>>> 4e655cf12fec726b26d1d6691bf5b09a0efd31e0
                                        nil];
    [selectSocialMedia showInView:[UIApplication sharedApplication].keyWindow];
}

<<<<<<< HEAD
- (IBAction)deleteImage:(id)sender {
}

=======
>>>>>>> 4e655cf12fec726b26d1d6691bf5b09a0efd31e0
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        [self postFacebook];
    }else if(buttonIndex == 1){
        [self postTwitter];
    }
}

- (void)postFacebook{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *fbController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [fbController setInitialText:[NSString stringWithFormat:@"Here's a picture from my meeting \"%@\", recorded with GroupMate!", meetingName]];
        [fbController addImage:image];
        
        [self presentViewController:fbController animated:YES completion:Nil];
        
    }
}

- (void)postTwitter{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        SLComposeViewController *twitterController = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitterController setInitialText:[NSString stringWithFormat:@"Here's a picture from my meeting \"%@\", recorded with #GroupMate!", meetingName]];
        [twitterController addImage:image];
        [self presentViewController:twitterController animated:YES completion:nil];
    }
}
@end
