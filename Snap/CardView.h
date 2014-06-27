//
//  CardView.h
//  Snap
//
//  Created by Ray Wenderlich on 5/27/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

const CGFloat CardWidth;
const CGFloat CardHeight;

@class Card;
@class Player;

@interface CardView : UIView

@property (nonatomic, strong) Card *card;

- (void)animateDealingToPlayer:(Player *)player withDelay:(NSTimeInterval)delay;
- (void)animateTurningOverForPlayer:(Player *)player;

@end
