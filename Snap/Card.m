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

- (id)initWithFile:(NSInteger)file
{
	if ((self = [super init]))
	{
		_file = file;
        _value = 0;
	}
	return self;
}

@end
