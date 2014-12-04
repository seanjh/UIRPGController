//
//  Baddie.m
//  UIRPGController
//
//  Created by Sean on 10/8/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import "Enemy.h"

@interface Enemy ()

@end

@implementation Enemy

-(id) init {
    return [self initWithNameString:[Enemy getRandomEnemyName] andLevelNumber:1];
}

+ (NSArray *)enemyNamesArray
{
    static NSArray *_names;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _names = @[@"Standard Spider",
                    @"Gangrenous Goat",
                    @"Leprous Lizard",
                    @"Mean Manatee",
                    @"Buxom Brontosaurus",
                    @"Rude Rhino",
                    @"Angry Axolotl"];
    });
    return _names;
}

+(NSString *) getRandomEnemyName {
    return [[Enemy enemyNamesArray] objectAtIndex:[GameAssistant generateRandomNumberBetweenMin:0 Max:([[Enemy enemyNamesArray] count] - 1)]];
}

@end
