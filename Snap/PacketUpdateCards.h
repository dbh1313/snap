//
//  PacketUpdateCards.h
//  Snap
//
//  Created by Ray Wenderlich on 5/27/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "Packet.h"
#import "Card.h"

@class Player;

@interface PacketUpdateCards : Packet

@property (nonatomic, strong) Card *card;

+ (id)packetWithCard:(Card *)card;

@end
