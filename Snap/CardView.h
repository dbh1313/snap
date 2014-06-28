//
//  CardView.h
//  Snap
//
//  Created by Ray Wenderlich on 5/27/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

@class Card;
@class Player;

@interface CardView : UIView

@property (nonatomic, strong) Card *card;

- (void)animateDealingToPlayer:(Player *)player withDelay:(NSTimeInterval)delay isServer:(BOOL)isServer;
- (void)animateTurningOverForPlayer:(Player *)player;
- (void)animateCardOnOffForPlayerWithDirection:(int)direction;
- (void)animateCardOnOffForServer:(BOOL)on inSlot:(int)inSlot;

@end
