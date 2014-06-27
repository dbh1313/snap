//
//  Deck.h
//  Snap
//
//  Created by Ray Wenderlich on 5/27/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

@class Card;

@interface Deck : NSObject

- (id)initWithFiles:(NSMutableArray*)files;
- (void)shuffle;
- (Card *)draw;
- (int)cardsRemaining;

@end
