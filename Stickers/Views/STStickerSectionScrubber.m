//
// STStickerSectionScrubber.m
// Stickers
//
// Created by Tomi De Lucca on 3/26/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "STStickerSectionScrubber.h"

#import <DKNightVersion/DKNightVersion.h>
#import <PureLayout/PureLayout.h>

@interface STStickerSectionScrubber ()
@property (strong, nonatomic) NSDictionary *scrubber;
@end

@implementation STStickerSectionScrubber

- (instancetype)initWithNumberOfSections:(NSUInteger)sections
{
	self = [super init];
	if (self) {
		[self setupViewWithNumberOfSections:sections];
	}
	return self;
}

- (void)setupViewWithNumberOfSections:(NSUInteger)sections
{
	NSMutableDictionary *sec = [[NSMutableDictionary alloc] initWithCapacity:sections];
	NSMutableArray *secViews = [[NSMutableArray alloc] initWithCapacity:sections];

	for (NSUInteger i = 0; i < sections; i++) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button dk_setBackgroundColorPicker:DKColorPickerWithKey(UNONWNED_STICKER_BG)];
		[button dk_setTintColorPicker:DKColorPickerWithKey(UNONWNED_STICKER_TITLE)];
		[button setTitle:[@(i)stringValue] forState:UIControlStateNormal];
		[button.layer setCornerRadius:6.0f];
		[button addTarget:self action:@selector(sectionWasSelected:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:button];
		[sec setObject:@(i) forKey:[NSValue valueWithNonretainedObject:button]];
		[secViews addObject:button];
	}

	self.scrubber = [sec copy];

	[secViews autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:15.0f];

	for (UIView *view in secViews) {
		[view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.0f];
		[view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10.0f];
	}

	UIView *separator = [UIView newAutoLayoutView];
	[separator dk_setBackgroundColorPicker:DKColorPickerWithKey(SEPARATOR_COLOR)];
	[self addSubview:separator];

	[separator autoSetDimension:ALDimensionHeight toSize:1.0f];
	[separator autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
}

- (void)sectionWasSelected:(UIButton *)sender
{
	NSValue *buttonValue = [NSValue valueWithNonretainedObject:sender];
	NSNumber *section = [self.scrubber objectForKey:buttonValue];

	if ([self.delegate respondsToSelector:@selector(didScrubToSection:)]) {
		[self.delegate didScrubToSection:[section unsignedIntegerValue]];
	}
}

@end
