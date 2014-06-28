//
//  Game.h
//  Snap
//
//  Created by Ray Wenderlich on 5/25/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "Player.h"
#import "GameGlobals.h"
#import "Deck.h"
#import "Packet.h"

@class Game;

@protocol GameDelegate <NSObject>

- (void)game:(Game *)game didQuitWithReason:(QuitReason)reason;
- (void)gameWaitingForServerReady:(Game *)game;
- (void)gameWaitingForClientsReady:(Game *)game;
- (void)gameDidBegin:(Game *)game;
- (void)gameUpdateServerCards:(Game *)game card:(Card *) card;
- (void)game:(Game *)game playerDidDisconnect:(Player *)disconnectedPlayer;
- (void)gameShouldDealCards:(Game *)game startingWithPlayer:(Player *)startingPlayer;
- (void)game:(Game *)game didActivatePlayer:(Player *)player;
- (void)game:(Game *)game player:(Player *)player turnedOverCard:(Card *)card;

@end

@interface Game : NSObject <GKSessionDelegate>

@property (nonatomic, weak) id <GameDelegate> delegate;
@property (nonatomic, assign) BOOL isServer;
@property (nonatomic, assign) NSString* playerName;
@property (nonatomic, assign) NSString* quest;
@property (nonatomic, assign) NSString* answer;
@property (nonatomic, assign) NSString* pointValue;

- (void)endGame;
- (void)sendPacketToServer:(Packet *)packet;
- (void)startClientGameWithSession:(GKSession *)session playerName:(NSString *)name server:(NSString *)peerID;
- (void)startServerGameWithSession:(GKSession *)session playerName:(NSString *)name clients:(NSArray *)clients;
- (void)quitGameWithReason:(QuitReason)reason;
- (Player *)playerAtPosition:(PlayerPosition)position;
- (void)beginRound;
- (Player *)activePlayer;
- (void)turnCardForPlayerAtBottom;

@end
