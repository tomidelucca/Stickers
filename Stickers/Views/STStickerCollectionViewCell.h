//
// STStickerCollectionViewCell.h
// Stickers
//
// Created by Tomi De Lucca on 3/24/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	STStickerCellStatusDoesntOwnSticker,
	STStickerCellStatusOwnsSticker
} STStickerCellStatus;

@interface STStickerCollectionViewCell : UICollectionViewCell
- (void)updateWithTitle:(NSString *)title andSubtitle:(NSString *)subtitle;
- (void)setStatus:(STStickerCellStatus)status;
@end
