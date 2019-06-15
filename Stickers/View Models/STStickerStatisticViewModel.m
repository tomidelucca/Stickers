//
// STStickerStatisticViewModel.m
// Stickers
//
// Created by Tomi De Lucca on 3/25/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "STStickerStatisticViewModel.h"

@interface STStickerStatisticViewModel ()
@property (weak, nonatomic) id <StickerDAO> dao;
@end

@implementation STStickerStatisticViewModel

- (instancetype)initWithStickerDAO:(id <StickerDAO> )dao
{
	self = [super init];
	if (self) {
		self.dao = dao;
	}
	return self;
}

- (NSArray <STStickerStatistic *> *)currentStatistics
{
	NSUInteger owned = [self.dao numberOfOwnedStickers];
	NSUInteger duplicated = [self.dao numberOfDuplicatedStickers];
	NSUInteger total = [self.dao numberOfStickers];

	STStickerStatistic *uniqueStickers = [[STStickerStatistic alloc] initWithTitle:@"Únicas" value:[@(owned)stringValue]];
	STStickerStatistic *duplicatedStickers = [[STStickerStatistic alloc] initWithTitle:@"Repetidas" value:[@(duplicated)stringValue]];
	STStickerStatistic *missingStickers = [[STStickerStatistic alloc] initWithTitle:@"Faltan" value:[@(total - owned)stringValue]];

	return @[uniqueStickers, duplicatedStickers, missingStickers];
}

- (NSDecimalNumber *)totalProgress
{
	NSUInteger owned = [self.dao numberOfOwnedStickers];
	NSUInteger total = [self.dao numberOfStickers];

	return [[NSDecimalNumber alloc] initWithFloat:(float)owned / (float)total];
}

@end
