//
//  StickersViewModel.h
//  Stickers
//
//  Created by Tomi De Lucca on 3/24/18.
//  Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StickerCollectionViewCell.h"
#import "StickerDAO.h"
#import "Sticker.h"

@interface StickersViewModel : NSObject

- (instancetype)initWithStickerDAO:(id<StickerDAO>)dao;

- (NSUInteger)numberOfSections;
- (StickerCellStatus)cellStatusForSticker:(Sticker*)sticker;
- (void)incrementAmountForSticker:(Sticker*)sticker;
- (void)decrementAmountForSticker:(Sticker*)sticker;
- (NSString *)titleForSection:(NSUInteger)section;
- (NSUInteger)numberOfStickersInSection:(NSUInteger)section;
- (Sticker *)stickerForSection:(NSUInteger)section andRow:(NSUInteger)row;
- (NSString *)duplicatedStickers;

@end
