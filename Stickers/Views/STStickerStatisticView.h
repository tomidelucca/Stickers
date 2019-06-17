//
// STStickerStatisticView.h
// Stickers
//
// Created by Tomi De Lucca on 3/25/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STStickerStatisticView : UIView
- (instancetype)initWithTitle:(NSString *)title;

- (void)updateWithValue:(NSString *)value;
@end
