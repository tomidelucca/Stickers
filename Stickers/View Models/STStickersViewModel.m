//
// STStickersViewModel.m
// Stickers
//
// Created by Tomi De Lucca on 3/24/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "STStickersViewModel.h"

@interface STStickersViewModel ()
@property (strong, nonatomic) id <StickerDAO> dao;
@end

@implementation STStickersViewModel

- (instancetype)initWithStickerDAO:(id <StickerDAO> )dao
{
	self = [super init];
	if (self) {
		self.dao = dao;
	}
	return self;
}

- (void)incrementAmountForSticker:(STSticker *)sticker
{
	sticker.amount++;
	[self.dao saveSticker:sticker];
}

- (void)decrementAmountForSticker:(STSticker *)sticker
{
	if (sticker.amount == 0) {
		return;
	}

	sticker.amount--;
	[self.dao saveSticker:sticker];
}

- (STSticker *)stickerForSection:(NSUInteger)section andRow:(NSUInteger)row
{
	return [self.dao stickerWithNumber:(section * 100 + row)];
}

- (NSString *)titleForSection:(NSUInteger)section
{
	return [NSString stringWithFormat:@"%ld", section * 100];
}

- (STStickerCellStatus)cellStatusForSticker:(STSticker *)sticker
{
	return sticker.amount ? STStickerCellStatusOwnsSticker : STStickerCellStatusDoesntOwnSticker;
}

- (NSUInteger)numberOfSections
{
	return ceil((double)[self.dao numberOfStickers] / 100.0f);
}

- (NSUInteger)numberOfStickersInSection:(NSUInteger)section
{
	NSUInteger stickerCount = [self.dao numberOfStickers];

	NSUInteger location = section * 100;
	NSUInteger length = 100;

	if (location + length >= stickerCount) {
		length = stickerCount % 100;
	}

	return length;
}

- (NSString *)duplicatedStickers
{
	NSMutableString *duplicated = [[NSMutableString alloc] init];

	NSArray *dup = [self.dao getDuplicateStickers];

	if (dup.count == 0) {
		return @"";
	}

	for (STSticker *sticker in dup) {
		[duplicated appendFormat:@"%ld, ", sticker.number];
	}

	return [duplicated substringWithRange:NSMakeRange(0, duplicated.length - 2)];
}

- (NSString *)missingStickers
{
	NSMutableString *missing = [[NSMutableString alloc] init];

	NSArray *mis = [self.dao getMissingStickers];

	if (mis.count == 0) {
		return @"";
	}

	for (STSticker *sticker in mis) {
		[missing appendFormat:@"%ld, ", sticker.number];
	}

	return [missing substringWithRange:NSMakeRange(0, missing.length - 2)];
}

@end
