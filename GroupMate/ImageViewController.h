//
//  ImageViewController.h
//  GroupMate
//
//  Created by K MacDonald on 2014-11-29.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "ViewController.h"

@interface ImageViewController : ViewController{
    UIImage *image;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (void) setImage:(UIImage*)currImage;

@end
