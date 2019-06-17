//
// STStickerCollectionViewCell.m
// Stickers
//
// Created by Tomi De Lucca on 3/24/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "STStickerCollectionViewCell.h"

#import <PureLayout/PureLayout.h>

@interface STStickerCollectionViewCell ()
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *subtitle;
@end

@implementation STStickerCollectionViewCell

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

- (void)updateWithTitle:(NSString *)title andSubtitle:(NSString *)subtitle
{
	[self.title setText:title];
	[self.subtitle setText:subtitle];
}

- (void)setStatus:(STStickerCellStatus)status
{
	switch (status) {
		case STStickerCellStatusDoesntOwnSticker: {
			[self setUnownedStatus];
		}
		break;

		case STStickerCellStatusOwnsSticker: {
			[self setOwnedStatus];
		}
		break;

		default: {
		}
		break;
	}
}

#pragma mark - Private

- (void)setUnownedStatus
{
	[self setBackgroundColor:[UIColor colorNamed:@"unowned-sticker-background"]];
	[self.title setTextColor:[UIColor colorNamed:@"unowned-sticker-title"]];
	[self.subtitle setTextColor:[UIColor colorNamed:@"unowned-sticker-subtitle"]];
}

- (void)setOwnedStatus
{
	[self setBackgroundColor:[UIColor colorNamed:@"owned-sticker-background"]];
	[self.title setTextColor:[UIColor colorNamed:@"owned-sticker-title"]];
	[self.subtitle setTextColor:[UIColor colorNamed:@"owned-sticker-subtitle"]];
}

@end
