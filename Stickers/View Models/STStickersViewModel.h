//
// STStickersViewModel.h
// Stickers
//
// Created by Tomi De Lucca on 3/24/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "STStickerCollectionViewCell.h"
#import "STStickerDAO.h"
#import "STSticker.h"

@interface STStickersViewModel : NSObject

- (instancetype)initWithStickerDAO:(id <STStickerDAO>)dao;

- (NSUInteger)numberOfSections;
- (STStickerCellStatus)cellStatusForSticker:(STSticker *)sticker;
- (void)incrementAmountForSticker:(STSticker *)sticker;
- (void)decrementAmountForSticker:(STSticker *)sticker;
- (NSString *)titleForSection:(NSUInteger)section;
- (NSUInteger)numberOfStickersInSection:(NSUInteger)section;
- (STSticker *)stickerForSection:(NSUInteger)section andRow:(NSUInteger)row;
- (NSString *)duplicatedStickers;
- (NSString *)missingStickers;

@end
