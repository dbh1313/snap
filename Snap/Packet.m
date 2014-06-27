//
//  Packet.m
//  Snap
//
//  Created by Ray Wenderlich on 5/25/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "Packet.h"
#import "NSData+SnapAdditions.h"
#import "PacketSignInResponse.h"
#import "PacketServerReady.h"
#import "PacketOtherClientQuit.h"
#import "Card.h"
#import "PacketDealCards.h"
#import "PacketActivatePlayer.h"

const size_t PACKET_HEADER_SIZE = 10;

@implementation Packet

@synthesize packetType = _packetType;

+ (id)packetWithType:(PacketType)packetType
{
	return [[[self class] alloc] initWithType:packetType];
}

+ (id)packetWithData:(NSData *)data
{
	if ([data length] < PACKET_HEADER_SIZE)
	{
		NSLog(@"Error: Packet too small");
		return nil;
	}
    
	if ([data rw_int32AtOffset:0] != 'SNAP')
	{
		NSLog(@"Error: Packet has invalid header");
		return nil;
	}
    
	int packetNumber = [data rw_int32AtOffset:4];
	PacketType packetType = [data rw_int16AtOffset:8];
    
	Packet *packet;
    
	switch (packetType)
	{
		case PacketTypeSignInRequest:
        case PacketTypeClientReady:
        case PacketTypeClientDealtCards:
        case PacketTypeServerQuit:
		case PacketTypeClientQuit:            
			packet = [Packet packetWithType:packetType];
			break;
            
		case PacketTypeSignInResponse:
			packet = [PacketSignInResponse packetWithData:data];
			break;
            
        case PacketTypeServerReady:
			packet = [PacketServerReady packetWithData:data];
			break;
            
        case PacketTypeOtherClientQuit:
			packet = [PacketOtherClientQuit packetWithData:data];
			break;

        case PacketTypeDealCards:
			packet = [PacketDealCards packetWithData:data];
			break;
            
        case PacketTypeActivatePlayer:
			packet = [PacketActivatePlayer packetWithData:data];
			break;            
            
		default:
			NSLog(@"Error: Packet has invalid type");
			return nil;
	}
    
	return packet;
}

- (id)initWithType:(PacketType)packetType
{
	if ((self = [super init]))
	{
		self.packetType = packetType;
	}
	return self;
}

- (NSData *)data
{
	NSMutableData *data = [[NSMutableData alloc] initWithCapacity:100];
    
	[data rw_appendInt32:'SNAP'];   // 0x534E4150
	[data rw_appendInt32:0];
	[data rw_appendInt16:self.packetType];
    
    [self addPayloadToData:data];
    
	return data;
}

- (void)addPayloadToData:(NSMutableData *)data
{
	// base class does nothing
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@, type=%d", [super description], self.packetType];
}

- (void)addCards:(NSMutableDictionary *)cards toPayload:(NSMutableData *)data
{
	[cards enumerateKeysAndObjectsUsingBlock:^(id key, NSArray *array, BOOL *stop)
     {
         [data rw_appendString:key];
         [data rw_appendInt8:[array count]];
         
         for (int t = 0; t < [array count]; ++t)
         {
             Card *card = [array objectAtIndex:t];
             [data rw_appendInt8:card.file];
         }
     }];
}

+ (NSMutableDictionary *)cardsFromData:(NSData *)data atOffset:(size_t) offset
{
	size_t count;
    
	NSMutableDictionary *cards = [NSMutableDictionary dictionaryWithCapacity:4];
    
	while (offset < [data length])
	{
		NSString *peerID = [data rw_stringAtOffset:offset bytesRead:&count];
		offset += count;
        
		int numberOfCards = [data rw_int8AtOffset:offset];
		offset += 1;
        
		NSMutableArray *array = [NSMutableArray arrayWithCapacity:numberOfCards];
        
		for (int t = 0; t < numberOfCards; ++t)
		{
			int file = [data rw_int8AtOffset:offset];
			offset += 1;
            
			int value = [data rw_int8AtOffset:offset];
			offset += 1;
            
			Card *card = [[Card alloc] initWithFile:file];
			[array addObject:card];
		}
        
		[cards setObject:array forKey:peerID];
	}
    
	return cards;
}

@end
