//
//  ImageCollectionViewCell.m
//  GroupMate
//
//  Created by K MacDonald on 2014-11-29.
//  Copyright (c) 2014 Katie, Tyler, & Arthur. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (id)init{
    self = [super init];
    if (self) {
        _image = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_image];
    }
    return self;
}

@end
