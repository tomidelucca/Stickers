//
// STStickerStatisticView.m
// Stickers
//
// Created by Tomi De Lucca on 3/25/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "STStickerStatisticView.h"

#import <PureLayout/PureLayout.h>

@interface STStickerStatisticView ()
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *value;
@end

@implementation STStickerStatisticView

- (instancetype)initWithTitle:(NSString *)title
{
	self = [super init];
	if (self) {
		[self setupViewWithTitle:title];
	}
	return self;
}

- (void)setupViewWithTitle:(NSString *)title
{
	self.title = [UILabel newAutoLayoutView];
	self.value = [UILabel newAutoLayoutView];

	[self addSubview:self.title];
	[self addSubview:self.value];

	[self.value autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
	[self.value autoSetDimension:ALDimensionHeight toSize:24.0f relation:NSLayoutRelationGreaterThanOrEqual];
	[self.title autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
	[self.title autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.value withOffset:6.0f];

	[self.title setTextColor:[UIColor colorNamed:@"text"]];
	[self.title setFont:[UIFont boldSystemFontOfSize:12.0f]];
	[self.title setTextAlignment:NSTextAlignmentCenter];
	[self.title setText:title];

	[self.value setTextColor:[UIColor colorNamed:@"stat-value-text"]];
	[self.value setBackgroundColor:[UIColor colorNamed:@"stat-value-background"]];
	[self.value setFont:[UIFont boldSystemFontOfSize:16.0f]];
	[self.value setTextAlignment:NSTextAlignmentCenter];
	[self.value.layer setCornerRadius:12.0f];
	[self.value setClipsToBounds:YES];
}

- (void)updateWithValue:(NSString *)value
{
	[self.value setText:value];
}

@end
