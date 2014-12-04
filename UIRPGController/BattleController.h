//
//  BattleController.h
//  UIRPGController
//
//  Created by Sean on 10/10/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hero.h"
#import "Enemy.h"
#import "GameAssistant.h"

@interface BattleController : NSObject

- (NSString *) getEnemyNameAtIndex:(long)index;
- (NSString *) getEnemyHealthSummaryAtIndex:(long)index;
- (float) getEnemyHealthPercentAtIndex:(long)index;
- (long)getEnemyCount;
- (NSString *) getHeroHealthSummary;
- (NSString *) getHeroManaSummary;
- (float) getHeroHealthPercent;
- (float) getHeroManaPercent;
- (void) pushDownDeadEnemies;
- (BOOL) attackEnemyAtIndex:(long)index;
- (BOOL) attackEnemiesWithSpell;

@end
