//
// StickerDAO.h
// Stickers
//
// Created by Tomi De Lucca on 3/24/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#ifndef StickerDAO_h
#define StickerDAO_h

#import "STSticker.h"

@protocol StickerDAO
- (NSUInteger)numberOfStickers;
- (NSUInteger)numberOfOwnedStickers;
- (NSUInteger)numberOfDuplicatedStickers;
- (void)saveSticker:(STSticker *)sticker;
- (NSArray <STSticker *> *)getDuplicateStickers;
- (NSArray <STSticker *> *)getMissingStickers;
- (STSticker *)stickerWithNumber:(NSUInteger)number;
@end

#endif
