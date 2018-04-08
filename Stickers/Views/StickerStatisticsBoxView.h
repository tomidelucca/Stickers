//
// StickerStatsView.h
// Stickers
//
// Created by Tomi De Lucca on 3/25/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StickerStatistic.h"

@interface StickerStatisticsBoxView : UIView
- (instancetype)initWithStatistics:(NSArray <StickerStatistic *> *)statistics;
- (void)updateWithStatistics:(NSArray <StickerStatistic *> *)statistics;
@end
