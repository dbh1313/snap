//
//  CardView.m
//  Snap
//
//  Created by Ray Wenderlich on 5/27/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "CardView.h"
#import "Card.h"
#import "Stack.h"
#import "Player.h"
#import "GameGlobals.h"

@implementation CardView
{
	UIImageView *_backImageView;
	UIImageView *_frontImageView;
	CGFloat _angle;
}

@synthesize card = _card;

- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{
		self.backgroundColor = [UIColor clearColor];
		[self loadBack];
	}
	return self;
}

- (void)loadBack
{
	if (_backImageView == nil)
	{
		_backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
		_backImageView.image = [UIImage imageNamed:@"Back"];
		_backImageView.contentMode = UIViewContentModeScaleToFill;
		[self addSubview:_backImageView];
	}
}

- (void)animateDealingToPlayer:(Player *)player withDelay:(NSTimeInterval)delay isServer:(BOOL)isServer
{
	self.frame = CGRectMake(-100.0f, -100.0f, CardWidth, CardHeight);
	self.transform = CGAffineTransformMakeRotation(M_PI);
    
	CGPoint point = [self centerForPlayer:player];
	_angle = [self angleForPlayer:player];
    
    if (isServer) {
        self.alpha = 0.0f;
    }
    
	[UIView animateWithDuration:0.2f
                          delay:delay
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         self.center = point;
         self.transform = CGAffineTransformMakeRotation(_angle);
     }
                     completion:nil];
}

- (CGPoint)centerForPlayer:(Player *)player
{
	CGRect rect = self.superview.bounds;
	CGFloat midX = CGRectGetMidX(rect);
	CGFloat midY = CGRectGetMidY(rect);
	CGFloat maxX = CGRectGetMaxX(rect);
	CGFloat maxY = CGRectGetMaxY(rect);
    
	CGFloat x = -3.0f + RANDOM_INT(6) + CardWidth/2.0f;
	CGFloat y = -3.0f + RANDOM_INT(6) + CardHeight/2.0f;
    
	if (self.card.isTurnedOver)
	{
//        x += midX + 7.0f;
        x += CardWidth + 7.0f;
        y += 150.0f;
    }
	else
	{
//        x += midX - CardWidth - 7.0f;
        x += CardWidth - 50.0f;
        y += 115.0f;
	}
    
	return CGPointMake(x, y);
}

- (void)unloadBack
{
	[_backImageView removeFromSuperview];
	_backImageView = nil;
}

- (void)loadFront
{
	if (_frontImageView == nil)
	{
		_frontImageView = [[UIImageView alloc] initWithFrame:self.bounds];
		_frontImageView.contentMode = UIViewContentModeScaleToFill;
		_frontImageView.hidden = YES;
		[self addSubview:_frontImageView];
        
		NSString *filename = [NSString stringWithFormat:@"Demo-%i", self.card.file];
		_frontImageView.image = [UIImage imageNamed:filename];
	}
}

- (CGFloat)angleForPlayer:(Player *)player
{
	float theAngle = (-0.5f + RANDOM_FLOAT()) / 4.0f;
    
	return theAngle;
}

- (void)animateTurningOverForPlayer:(Player *)player
{
	[self loadFront];
	[self.superview bringSubviewToFront:self];
    
    float screenWidth = [UIScreen mainScreen].applicationFrame.size.height; // hackday, too lazy to get proper orientation
    
	UIImageView *darkenView = [[UIImageView alloc] initWithFrame:self.bounds];
	darkenView.backgroundColor = [UIColor clearColor];
	darkenView.image = [UIImage imageNamed:@"Darken"];
	darkenView.alpha = 0.0f;
	[self addSubview:darkenView];

	CGPoint startPoint = self.center;
	CGPoint endPoint = [self centerForPlayer:player];
    endPoint.y = PLAYER_CARD_ROW_Y;
    
    // Calculate x position based on card and total cards
    int totalCards = player.closedCards.cardCount + player.openCards.cardCount;
    int thisCard = (totalCards - player.closedCards.cardCount) - 1;  // account for "this" card already dealt
    float cardContainerWidth = (screenWidth / (float)totalCards) - 35.0f;
    endPoint.x = ((float)thisCard * cardContainerWidth) + ((cardContainerWidth - CardWidth) / 2.0f) + 150.0f;
    
    
	CGFloat afterAngle = [self angleForPlayer:player];
    
	CGPoint halfwayPoint = CGPointMake((startPoint.x + endPoint.x)/2.0f, (startPoint.y + endPoint.y)/2.0f);
	CGFloat halfwayAngle = (_angle + afterAngle)/2.0f;
    
	[UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         CGRect rect = _backImageView.bounds;
         rect.size.width = 1.0f;
         _backImageView.bounds = rect;
         
         darkenView.bounds = rect;
         darkenView.alpha = 0.5f;
         
         self.center = halfwayPoint;
         self.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(halfwayAngle), 1.2f, 1.2f);
     }
                     completion:^(BOOL finished)
     {
         _frontImageView.bounds = _backImageView.bounds;
         _frontImageView.hidden = NO;
         
         [UIView animateWithDuration:0.15f
                               delay:0
                             options:UIViewAnimationOptionCurveEaseOut
                          animations:^
          {
              CGRect rect = _frontImageView.bounds;
              rect.size.width = CardWidth;
              _frontImageView.bounds = rect;
              
              darkenView.bounds = rect;
              darkenView.alpha = 0.0f;
              
              self.center = endPoint;
              self.transform = CGAffineTransformMakeRotation(afterAngle);
          }
                          completion:^(BOOL finished)
          {
              [darkenView removeFromSuperview];
              [self unloadBack];
          }];
     }];
}

- (void)animateCardOnOffForPlayerWithDirection:(int)direction
{
	[self loadFront];
	[self.superview bringSubviewToFront:self];
	CGPoint endPoint = self.center;
    
    // Calculate x position and y position for top row
    if (direction > 0) {
        endPoint.y = PLAYER_CARD_ROW_ON_Y;
    }
    else {
        endPoint.y = PLAYER_CARD_ROW_Y;
    }
    
    [UIView animateWithDuration:0.15f
                       delay:0
                     options:UIViewAnimationOptionCurveEaseOut
                  animations:^
    {
      CGRect rect = _frontImageView.bounds;
      rect.size.width = CardWidth;
      _frontImageView.bounds = rect;
      
      self.center = endPoint;
    }
                  completion:^(BOOL finished)
    {
        NSLog(@"done animating card to on");
    }];
}

- (void)animateCardOnOffForServer:(BOOL)on inSlot:(int)inSlot
{
	[self loadFront];
    _frontImageView.bounds = _backImageView.bounds;
    _frontImageView.hidden = NO;
	[self.superview bringSubviewToFront:self];
	CGPoint endPoint = self.center;
    endPoint.y = SERVER_CARD_ROW_ON_Y;
    
    // Calculate x position based on card and total cards
    float screenWidth = [UIScreen mainScreen].applicationFrame.size.height; // hackday, too lazy to get proper orientation
    float cardContainerWidth = (screenWidth / (float)MAX_CORRECT_CARDS) - 35.0f;
    endPoint.x = ((float)inSlot * cardContainerWidth) + ((cardContainerWidth - CardWidth) / 2.0f) + 150.0f;
    self.center = endPoint;
    
    float destAlpha = 0.0f;
    if (on) {
        destAlpha = 1.0f;
    }
    else {
        destAlpha = 0.0f;
    }
    
    [UIView animateWithDuration:1.0f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         self.alpha = destAlpha;
     }
                     completion:^(BOOL finished)
     {
         NSLog(@"done animating card to on");
     }];
}


@end
