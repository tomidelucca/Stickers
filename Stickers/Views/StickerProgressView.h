//
//  StickerProgressView.h
//  Stickers
//
//  Created by Tomi De Lucca on 3/25/18.
//  Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StickerProgressView : UIView
- (void)updateWithProgress:(NSDecimalNumber*)progress;
@end
