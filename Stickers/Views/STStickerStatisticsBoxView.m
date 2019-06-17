//
// STStickerStatisticsBoxView.m
// Stickers
//
// Created by Tomi De Lucca on 3/25/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "STStickerStatisticsBoxView.h"

#import "STStickerStatisticView.h"

#import <PureLayout/PureLayout.h>

@interface STStickerStatisticsBoxView ()
@property (strong, nonatomic) NSDictionary *statistics;
@end

@implementation STStickerStatisticsBoxView

- (instancetype)initWithStatistics:(NSArray <STStickerStatistic *> *)statistics
{
	self = [super init];
	if (self) {
		[self setupViewWithStatistics:statistics];
	}
	return self;
}

- (void)setupViewWithStatistics:(NSArray <STStickerStatistic *> *)statistics
{
	[self setBackgroundColor:[UIColor colorNamed:@"background"]];

	NSMutableDictionary *stats = [[NSMutableDictionary alloc] initWithCapacity:statistics.count];
	NSMutableArray *statsViews = [[NSMutableArray alloc] initWithCapacity:statistics.count];

	UIView *containerView = [UIView newAutoLayoutView];
	[self addSubview:containerView];

	[containerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20.0f, 10.0f, 20.0f, 10.0f)];

	for (STStickerStatistic *stat in statistics) {
		STStickerStatisticView *sv = [[STStickerStatisticView alloc] initWithTitle:stat.title];
		[sv updateWithValue:stat.value];
		[containerView addSubview:sv];
		[statsViews addObject:sv];
		[stats setObject:sv forKey:stat.title];
	}

	[statsViews autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:15.0f];

	for (UIView *view in statsViews) {
		[view autoPinEdgeToSuperviewEdge:ALEdgeTop];
		[view autoPinEdgeToSuperviewEdge:ALEdgeBottom];
	}

	self.statistics = [stats copy];
}

- (void)updateWithStatistics:(NSArray <STStickerStatistic *> *)statistics
{
	for (STStickerStatistic *stat in statistics) {
		STStickerStatisticView *sv = [self.statistics objectForKey:stat.title];
		[sv updateWithValue:stat.value];
	}
}

@end
