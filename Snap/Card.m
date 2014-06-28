//
//  Card.m
//  Snap
//
//  Created by Ray Wenderlich on 5/27/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize file = _file;
@synthesize value = _value;
@synthesize isTurnedOver = _isTurnedOver;
@synthesize isActive = _isActive;
@synthesize inSlot = inSlot;

- (id)initWithFile:(NSInteger)file value:(NSInteger)value
{
	if ((self = [super init]))
	{
		_file = file;
        _value = value;
        _isActive = NO;
        inSlot = -1;
	}
	return self;
}

@end
