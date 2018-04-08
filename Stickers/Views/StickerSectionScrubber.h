//
// StickerSectionScrubber.h
// Stickers
//
// Created by Tomi De Lucca on 3/26/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StickerSectionScrubberDelegate <NSObject>
- (void)didScrubToSection:(NSUInteger)section;
@end

@interface StickerSectionScrubber : UIView
@property (weak, nonatomic) id <StickerSectionScrubberDelegate> delegate;
- (instancetype)initWithNumberOfSections:(NSUInteger)sections;
@end
