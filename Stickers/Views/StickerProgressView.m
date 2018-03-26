//
//  StickerProgressView.m
//  Stickers
//
//  Created by Tomi De Lucca on 3/25/18.
//  Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "StickerProgressView.h"

#import <DKNightVersion/DKNightVersion.h>
#import <PureLayout/PureLayout.h>

@interface StickerProgressView()
@property (strong, nonatomic) UILabel *percentage;
@property (strong, nonatomic) UIProgressView *progressBar;
@end

@implementation StickerProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.percentage = [UILabel newAutoLayoutView];
    self.progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    
    [self addSubview: self.percentage];
    [self addSubview: self.progressBar];
    
    [self.progressBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f) excludingEdge:ALEdgeBottom];
    [self.percentage autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f) excludingEdge:ALEdgeTop];
    [self.percentage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.progressBar withOffset:6.0f];
    
    [self.percentage setFont:[UIFont systemFontOfSize:12.0f]];
    [self.percentage setTextAlignment:NSTextAlignmentCenter];
    [self.percentage dk_setTextColorPicker:DKColorPickerWithKey(TEXT)];
    
    [self.progressBar dk_setTintColorPicker:DKColorPickerWithKey(PROGRESS_BAR_FILL)];
    [self.progressBar dk_setBackgroundColorPicker:DKColorPickerWithKey(PROGRESS_BAR_BG)];
}

- (void)updateWithProgress:(NSDecimalNumber*)progress
{
    [self.progressBar setProgress: [progress floatValue]];
    [self.percentage setText:[NSString stringWithFormat:@"%.0f%%", ([progress floatValue] * 100)]];
}

@end
