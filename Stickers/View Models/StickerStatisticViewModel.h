//
// StickerStatisticViewModel.h
// Stickers
//
// Created by Tomi De Lucca on 3/25/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StickerStatistic.h"
#import "StickerDAO.h"

@interface StickerStatisticViewModel : NSObject
- (instancetype)initWithStickerDAO:(id <StickerDAO> )dao;
- (NSArray <StickerStatistic *> *)currentStatistics;
- (NSDecimalNumber *)totalProgress;
@end
