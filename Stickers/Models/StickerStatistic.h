//
// StickerStatistic.h
// Stickers
//
// Created by Tomi De Lucca on 3/25/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StickerStatistic : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *value;
- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value;
@end
