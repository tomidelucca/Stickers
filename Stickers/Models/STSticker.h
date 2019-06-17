//
// STSticker.h
// Stickers
//
// Created by Tomi De Lucca on 3/24/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STSticker : NSObject
- (instancetype)initWithNumber:(NSUInteger)number amount:(NSUInteger)amount;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger amount;
@end
