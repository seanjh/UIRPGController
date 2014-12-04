//
//  GameAssistant.m
//  UIRPGController
//
//  Created by Sean on 10/10/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import "GameAssistant.h"

@interface GameAssistant ()

@end

@implementation GameAssistant

+(long)generateRandomNumberBetweenMin:(long)min Max:(long)max
{
    return ( (arc4random() % (max-min+1)) + min );
}

@end
