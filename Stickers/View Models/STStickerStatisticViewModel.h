//
// STStickerStatisticViewModel.h
// Stickers
//
// Created by Tomi De Lucca on 3/25/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "STStickerStatistic.h"
#import "StickerDAO.h"

@interface STStickerStatisticViewModel : NSObject
- (instancetype)initWithStickerDAO:(id <StickerDAO> )dao;
- (NSArray <STStickerStatistic *> *)currentStatistics;
- (NSDecimalNumber *)totalProgress;
@end
