//
//  PacketDealCards.h
//  Snap
//
//  Created by Ray Wenderlich on 5/27/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "Packet.h"

@class Player;

@interface PacketDealCards : Packet

@property (nonatomic, strong) NSDictionary *cards;
@property (nonatomic, copy) NSString *startingPeerID;

+ (id)packetWithCards:(NSDictionary *)cards startingWithPlayerPeerID:(NSString *)startingPeerID;

@end
