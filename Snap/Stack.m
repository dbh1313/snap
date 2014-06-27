//
//  Stack.m
//  Snap
//
//  Created by Ray Wenderlich on 5/27/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "Stack.h"
#import "Card.h"
#import "GameGlobals.h"

@implementation Stack
{
	NSMutableArray *_cards;
}

- (id)init
{
	if ((self = [super init]))
	{
		_cards = [NSMutableArray arrayWithCapacity:MAX_CARDS_PER_QUEST / 2];
	}
	return self;
}

- (void)addCardToTop:(Card *)card
{
	NSAssert(card != nil, @"Card cannot be nil");
	NSAssert([_cards indexOfObject:card] == NSNotFound, @"Already have this Card");
	[_cards addObject:card];
}

- (NSUInteger)cardCount
{
	return [_cards count];
}

- (NSArray *)array
{
	return [_cards copy];
}

- (Card *)cardAtIndex:(NSUInteger)index
{
	return [_cards objectAtIndex:index];
}

- (void)addCardsFromArray:(NSArray *)array
{
	_cards = [array mutableCopy];
}

- (Card *)topmostCard
{
	return [_cards lastObject];
}

- (void)removeTopmostCard
{
	[_cards removeLastObject];
}

@end
