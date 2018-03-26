//
//  StickerCollectionViewCell.m
//  Stickers
//
//  Created by Tomi De Lucca on 3/24/18.
//  Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "StickerCollectionViewCell.h"

#import <DKNightVersion/DKNightVersion.h>
#import <PureLayout/PureLayout.h>

@interface StickerCollectionViewCell()
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *subtitle;
@end

@implementation StickerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self setBackgroundColor:[UIColor lightGrayColor]];
    
    self.title = [UILabel newAutoLayoutView];
    self.subtitle = [UILabel newAutoLayoutView];
    
    [self addSubview:self.title];
    [self addSubview:self.subtitle];
    
    [self.title autoCenterInSuperview];
    [self.subtitle autoPinEdgesToSuperviewMarginsExcludingEdge:ALEdgeTop];
    
    [self.title setFont:[UIFont boldSystemFontOfSize:20.0f]];
    
    [self.subtitle setTextAlignment:NSTextAlignmentRight];
    [self.subtitle setFont:[UIFont systemFontOfSize:14.0f]];
    
    [self.layer setCornerRadius:6.0f];
}

- (void)updateWithTitle:(NSString*)title andSubtitle:(NSString*)subtitle
{
    [self.title setText:title];
    [self.subtitle setText:subtitle];
}

- (void)setStatus:(StickerCellStatus)status
{
    switch (status) {
        case StickerCellStatusDoesntOwnSticker:
            [self setUnownedStatus];
            break;
        case StickerCellStatusOwnsSticker:
            [self setOwnedStatus];
            break;
        default:
            break;
    }
}

#pragma mark - Private

- (void)setUnownedStatus
{
    [self dk_setBackgroundColorPicker:DKColorPickerWithKey(UNONWNED_STICKER_BG)];
    [self.title dk_setTextColorPicker:DKColorPickerWithKey(UNONWNED_STICKER_TITLE)];
    [self.subtitle dk_setTextColorPicker:DKColorPickerWithKey(UNONWNED_STICKER_SUBTITLE)];
}

- (void)setOwnedStatus
{
    [self dk_setBackgroundColorPicker:DKColorPickerWithKey(OWNED_STICKER_BG)];
    [self.title dk_setTextColorPicker:DKColorPickerWithKey(OWNED_STICKER_TITLE)];
    [self.subtitle dk_setTextColorPicker:DKColorPickerWithKey(OWNED_STICKER_SUBTITLE)];
}

@end
