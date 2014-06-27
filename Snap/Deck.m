//
//  Deck.m
//  Snap
//
//  Created by Ray Wenderlich on 5/27/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "Deck.h"
#import "GameGlobals.h"
#import "Card.h"

@implementation Deck
{
	NSMutableArray *_cards;
}

- (id)setUpCardsWith:(NSMutableArray*)files
{
    for (NSUInteger i = 0, count = MAX_CARDS_PER_QUEST; i < count; i++)
    {
        Card *card = [[Card alloc] initWithFile:[[files lastObject] intValue]];
        [_cards addObject:card];
    }
    
    return self;
}

- (id)initWithFiles:(NSMutableArray*)files
{
	if ((self = [super init]))
	{
        _cards = [[NSMutableArray alloc] initWithCapacity:MAX_CARDS_PER_QUEST];
		[self setUpCardsWith:files];
	}
	return self;
}

- (int)cardsRemaining
{
	return [_cards count];
}

- (void)shuffle
{
	NSUInteger count = [_cards count];
	NSMutableArray *shuffled = [NSMutableArray arrayWithCapacity:count];
    
	for (int t = 0; t < count; ++t)
	{
		int i = arc4random() % [self cardsRemaining];
		Card *card = [_cards objectAtIndex:i];
		[shuffled addObject:card];
		[_cards removeObjectAtIndex:i];
	}
    
	NSAssert([self cardsRemaining] == 0, @"Original deck should now be empty");
    
	_cards = shuffled;
}

- (Card *)draw
{
	NSAssert([self cardsRemaining] > 0, @"No more cards in the deck");
	Card *card = [_cards lastObject];
	[_cards removeLastObject];
	return card;
}

@end
