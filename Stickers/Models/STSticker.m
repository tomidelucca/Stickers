//
// STSticker.m
// Stickers
//
// Created by Tomi De Lucca on 3/24/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "STSticker.h"

@implementation STSticker

- (instancetype)initWithNumber:(NSUInteger)number amount:(NSUInteger)amount
{
	self = [super init];
	if (self) {
		self.number = number;
		self.amount = amount;
	}
	return self;
}

@end
