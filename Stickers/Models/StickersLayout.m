//
//  StickersLayout.m
//  Stickers
//
//  Created by Tomi De Lucca on 3/24/18.
//  Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "StickersLayout.h"

@implementation StickersLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout
{
    self.itemSize = CGSizeMake(75.0f, 75.0f);
    self.minimumInteritemSpacing = 2.0f;
    self.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
}

@end
