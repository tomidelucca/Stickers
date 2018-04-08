//
// StickerStatistic.m
// Stickers
//
// Created by Tomi De Lucca on 3/25/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "StickerStatistic.h"

@implementation StickerStatistic

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value
{
	self = [super init];
	if (self) {
		self.title = title;
		self.value = value;
	}
	return self;
}

@end
