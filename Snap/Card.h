//
//  Card.h
//  Snap
//
//  Created by Ray Wenderlich on 5/27/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#define CardAce   1
#define CardJack  11
#define CardQueen 12
#define CardKing  13


@interface Card : NSObject

@property (nonatomic, assign, readonly) int file;
@property (nonatomic, assign, readonly) int value;
@property (nonatomic, assign) BOOL isTurnedOver;

- (id)initWithFile:(NSInteger)file;

@end
