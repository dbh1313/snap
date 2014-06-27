//
//  Stack.h
//  Snap
//
//  Created by Ray Wenderlich on 5/27/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

@class Card;

@interface Stack : NSObject

- (void)addCardToTop:(Card *)card;
- (NSUInteger)cardCount;
- (NSArray *)array;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)addCardsFromArray:(NSArray *)array;
- (Card *)topmostCard;
- (void)removeTopmostCard;

@end
