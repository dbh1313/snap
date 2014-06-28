//
//  PacketUpdateCards.m
//  Snap
//
//  Created by Ray Wenderlich on 5/27/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "PacketUpdateCards.h"
#import "NSData+SnapAdditions.h"
#import "Card.h"

@implementation PacketUpdateCards

@synthesize card = _card;

+ (id)packetWithCard:(Card *)card
{
    return [[[self class] alloc] initWithCard:card];
}

- (id)initWithCard:(Card *)card
{
	if ((self = [super initWithType:PacketTypeUpdateCards]))
	{
		self.card = card;
	}
	return self;
}

+ (id)packetWithData:(NSData *)data
{
	size_t offset = PACKET_HEADER_SIZE;
	size_t count;
    int file = [data rw_int8AtOffset:offset];
    offset += 1;
    
    int value = [data rw_int8AtOffset:offset];
    offset += 1;
    
    Card* card = [[Card alloc] initWithFile:file value:value];
    
	return [[self class] packetWithCard:card];
}

- (void)addPayloadToData:(NSMutableData *)data
{
    [data rw_appendInt8:self.card.file];
    [data rw_appendInt8:self.card.value];
}

@end
