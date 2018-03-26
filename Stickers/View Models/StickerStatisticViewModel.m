//
//  StickerStatisticViewModel.m
//  Stickers
//
//  Created by Tomi De Lucca on 3/25/18.
//  Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "StickerStatisticViewModel.h"

@interface StickerStatisticViewModel()
@property (weak, nonatomic) id<StickerDAO> dao;
@end

@implementation StickerStatisticViewModel

- (instancetype)initWithStickerDAO:(id<StickerDAO>)dao
{
    self = [super init];
    if (self) {
        self.dao = dao;
    }
    return self;
}

- (NSArray<StickerStatistic*>*)currentStatistics
{
    NSUInteger owned = [self.dao numberOfOwnedStickers];
    NSUInteger duplicated = [self.dao numberOfDuplicatedStickers];
    NSUInteger total = [self.dao numberOfStickers];
    
    StickerStatistic *uniqueStickers = [[StickerStatistic alloc] initWithTitle:@"Únicas" value:[@(owned) stringValue]];
    StickerStatistic *duplicatedStickers = [[StickerStatistic alloc] initWithTitle:@"Repetidas" value:[@(duplicated) stringValue]];
    StickerStatistic *missingStickers = [[StickerStatistic alloc] initWithTitle:@"Faltan" value:[@(total - owned) stringValue]];
    
    return @[uniqueStickers, duplicatedStickers, missingStickers];
}

- (NSDecimalNumber*)totalProgress
{
    NSUInteger owned = [self.dao numberOfOwnedStickers];
    NSUInteger total = [self.dao numberOfStickers];
    
    return [[NSDecimalNumber alloc] initWithFloat: (float)owned/(float)total];
}

@end
