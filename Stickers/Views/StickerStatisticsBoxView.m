//
//  StickerStatsView.m
//  Stickers
//
//  Created by Tomi De Lucca on 3/25/18.
//  Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "StickerStatisticsBoxView.h"

#import "StickerStatisticView.h"

#import <DKNightVersion/DKNightVersion.h>
#import <PureLayout/PureLayout.h>

@interface StickerStatisticsBoxView()
@property (strong, nonatomic) NSDictionary *statistics;
@end

@implementation StickerStatisticsBoxView

- (instancetype)initWithStatistics:(NSArray<StickerStatistic*>*)statistics
{
    self = [super init];
    if (self) {
        [self setupViewWithStatistics:statistics];
    }
    return self;
}

- (void)setupViewWithStatistics:(NSArray<StickerStatistic*>*)statistics
{
    [self dk_setBackgroundColorPicker:DKColorPickerWithKey(BG)];
    
    NSMutableDictionary *stats = [[NSMutableDictionary alloc] initWithCapacity:statistics.count];
    NSMutableArray *statsViews = [[NSMutableArray alloc] initWithCapacity:statistics.count];
    
    UIView *containerView = [UIView newAutoLayoutView];
    [self addSubview:containerView];
    
    [containerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20.0f, 10.0f, 20.0f, 10.0f)];

    for (StickerStatistic* stat in statistics) {
        StickerStatisticView *sv = [[StickerStatisticView alloc] initWithTitle:stat.title];
        [sv updateWithValue:stat.value];
        [containerView addSubview:sv];
        [statsViews addObject:sv];
        [stats setObject:sv forKey:stat.title];
    }
    
    [statsViews autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:15.0f];
    
    for (UIView* view in statsViews) {
        [view autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [view autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    }
    
    self.statistics = [stats copy];
}

- (void)updateWithStatistics:(NSArray<StickerStatistic*>*)statistics
{
    for (StickerStatistic *stat in statistics) {
        StickerStatisticView *sv = [self.statistics objectForKey:stat.title];
        [sv updateWithValue:stat.value];
    }
}

@end
