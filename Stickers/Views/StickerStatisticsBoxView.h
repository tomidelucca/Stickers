//
// StickerStatsView.h
// Stickers
//
// Created by Tomi De Lucca on 3/25/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "STStickerStatistic.h"

@interface StickerStatisticsBoxView : UIView
- (instancetype)initWithStatistics:(NSArray <STStickerStatistic *> *)statistics;
- (void)updateWithStatistics:(NSArray <STStickerStatistic *> *)statistics;
@end
