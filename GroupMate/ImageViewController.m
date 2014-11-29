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
    
    [self.navigationItem setRightBarButtonItem:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) setImage:(UIImage*)currImage{
    image = currImage;
}

@end
