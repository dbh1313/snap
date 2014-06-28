//
//  Deck.h
//  Snap
//
//  Created by Ray Wenderlich on 5/27/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

@class Card;

@interface Deck : NSObject

@property (nonatomic, assign, readonly) int file;
@property (nonatomic, assign, readonly) int value;

- (id)initWithFiles:(NSMutableArray*)files values:(NSMutableArray*)values;
- (void)shuffle;
- (Card *)draw;
- (int)cardsRemaining;

@end
