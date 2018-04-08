//
//  UserDefaultsStickerDAO.m
//  Stickers
//
//  Created by Tomi De Lucca on 3/24/18.
//  Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "UserDefaultsStickerDAO.h"

static NSString * const kStickerRoot = @"sticker_root";
static NSString * const kStickerNumber = @"number";
static NSString * const kStickerAmount = @"amount";
static NSInteger kStickerMax = 669;

@interface UserDefaultsStickerDAO()
@property (weak, nonatomic) NSUserDefaults *defaults;
@property (strong, nonatomic) NSMutableArray *cache;
@property (nonatomic) BOOL dirty;
@end

@implementation UserDefaultsStickerDAO

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupDAO];
    }
    return self;
}

- (void)setupDAO
{
    if ([self isFirstLaunch]) {
        [self populateDAO];
    }
    
    self.cache = [[self.defaults objectForKey:kStickerRoot] mutableCopy];
    self.dirty = NO;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
}

- (NSUserDefaults*)defaults
{
    if (!_defaults) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return _defaults;
}

- (NSUInteger)numberOfStickers
{
    return self.cache.count;
}

- (NSUInteger)numberOfOwnedStickers
{
    NSUInteger owned = 0;
    for (NSDictionary *sticker in self.cache) {
        if ([[sticker objectForKey:kStickerAmount] unsignedIntegerValue] > 0) {
            owned++;
        }
    }
    
    return owned;
}

- (NSUInteger)numberOfDuplicatedStickers
{
    NSUInteger duplicated = 0;
    for (NSDictionary *sticker in self.cache) {
        if ([[sticker objectForKey:kStickerAmount] unsignedIntegerValue] > 1) {
            duplicated += ([[sticker objectForKey:kStickerAmount] unsignedIntegerValue] - 1);
        }
    }
    
    return duplicated;
}

- (NSArray<Sticker*>*)getDuplicateStickers
{
    NSMutableArray *duplicate = [[NSMutableArray alloc] init];
    
    for (NSDictionary *sticker in self.cache) {
        if ([[sticker objectForKey:kStickerAmount] unsignedIntegerValue] > 1) {
            [duplicate addObject:[self dictionaryToSticker:sticker]];
        }
    }
    
    return [duplicate copy];
}

- (NSArray<Sticker*>*)getMissingStickers
{
    NSMutableArray *missing = [[NSMutableArray alloc] init];
    
    for (NSDictionary *sticker in self.cache) {
        if ([[sticker objectForKey:kStickerAmount] unsignedIntegerValue] == 0) {
            [missing addObject:[self dictionaryToSticker:sticker]];
        }
    }
    
    return [missing copy];
}

- (void)saveSticker:(Sticker *)sticker {
    NSMutableDictionary *copy = [[self.cache objectAtIndex:sticker.number] mutableCopy];
    [copy setObject:@(sticker.amount) forKey:kStickerAmount];
    [self.cache replaceObjectAtIndex:sticker.number withObject:[copy copy]];
    self.dirty = YES;
}

- (Sticker *)stickerWithNumber:(NSUInteger)number {
    NSDictionary* sticker = [self.cache objectAtIndex:number];
    return [[Sticker alloc] initWithNumber:[[sticker objectForKey:kStickerNumber] unsignedIntegerValue] amount:[[sticker objectForKey:kStickerAmount] unsignedIntegerValue]];
}

#pragma mark - Private

- (void)populateDAO
{
    NSMutableArray *cache = [NSMutableArray new];
    
    for (NSUInteger i = 0; i <= kStickerMax ; i++) {
        Sticker *sticker = [[Sticker alloc] initWithNumber:i amount:0];
        [cache addObject:[self stickerToDictionary:sticker]];
    }
    
    [self.defaults setObject:cache forKey:kStickerRoot];
    [self.defaults synchronize];
}

- (BOOL)isFirstLaunch
{
    return ![self.defaults objectForKey:kStickerRoot];
}

- (Sticker*)dictionaryToSticker:(NSDictionary*)dictionary
{
    return [[Sticker alloc] initWithNumber:[[dictionary objectForKey:kStickerNumber] unsignedIntegerValue] amount:[[dictionary objectForKey:kStickerAmount] unsignedIntegerValue]];
}

- (NSDictionary*)stickerToDictionary:(Sticker*)sticker
{
    return @{kStickerNumber : @(sticker.number), kStickerAmount : @(sticker.amount)};
}

- (void)appWillResignActive:(NSNotification*)notification
{
    if (self.dirty) {
        [self.defaults setObject:self.cache forKey:kStickerRoot];
        self.dirty = NO;
    }
}

@end
