//
//  ClientGameViewController.h
//  Snap
//
//  Created by Ray Wenderlich on 5/25/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "Game.h"

@class ClientGameViewController;

@protocol ClientGameViewControllerDelegate <NSObject>

- (void)ClientGameViewController:(ClientGameViewController *)controller didQuitWithReason:(QuitReason)reason;

@end

@interface ClientGameViewController : UIViewController <UIAlertViewDelegate, GameDelegate>

@property (nonatomic, weak) id <ClientGameViewControllerDelegate> delegate;
@property (nonatomic, strong) Game *game;

@end
