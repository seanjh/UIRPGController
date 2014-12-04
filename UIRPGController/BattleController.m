//
//  BattleController.m
//  UIRPGController
//
//  Created by Sean on 10/10/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import "BattleController.h"
#import "GameManager.h"
#import "Enemy.h"
#import "Hero.h"

@interface BattleController ()
@property (nonatomic,strong) GameManager *sharedManager;
@property (nonatomic,strong) Hero *hero;
@property (nonatomic,strong) NSMutableArray *enemies;

@end

@implementation BattleController

- (id) init {
    self.sharedManager = [GameManager sharedManager];
    self.hero = self.sharedManager.theHero;
    self.enemies = self.sharedManager.currentRoom.enemies;
    return self;
}

- (NSString *) getEnemyNameAtIndex:(long)index {
    Enemy *tmpEnemy = [self.enemies objectAtIndex:index];
    return tmpEnemy.name;
}

- (NSString *) getEnemyHealthSummaryAtIndex:(long)index {
    Enemy *tmpEnemy = [self.enemies objectAtIndex:index];
    return [NSString stringWithFormat:@"%d/%d", tmpEnemy.health, [tmpEnemy getMaxHealthThisLevel]];
}

- (float) getEnemyHealthPercentAtIndex:(long)index {
    Enemy *tmpEnemy = [self.enemies objectAtIndex:index];
    return (float) tmpEnemy.health / (float) [tmpEnemy getMaxHealthThisLevel];
}

-(int) getSpellCastCooldown {
    return self.hero.cooldownSeconds;
}

- (void) pushDownDeadEnemies {
    long num = [self getEnemyCount];
    long j;
    Enemy *bottom;
    // Get the first alive enemy from the bottom
    for (j = num - 1; j > 0; j--) {
        bottom = [self.enemies objectAtIndex:j];
        if ([bottom isAlive]) {
            break;
        }
    }
    
    long i;
    Enemy *top;
    Enemy *swap;
    NSLog(@"Starting to pushing down dead enemies: %@", self.enemies);
    for (i = 0; i < j; i++) {
        top = [self.enemies objectAtIndex:i];
        bottom = [self.enemies objectAtIndex:j];
        if (![top isAlive]) {
            if ([bottom isAlive]) {
                // Swap the top and bottom
                swap = bottom;
                [self.enemies replaceObjectAtIndex:i withObject:bottom];
                [self.enemies replaceObjectAtIndex:j withObject:top];
                // Push up the bottom above the dead enemy
                j--;
            } else {
                // Bottom of the list enemy is dead
                break;
            }
        }
    }
    NSLog(@"Finished pushing down dead enemies: %@", self.enemies);
}

- (long) getEnemyCount {
    return [self.enemies count];
}

- (long) getLivingEnemyCount {
    long alive = 0;
    for (Enemy *enemy in self.enemies) {
        if ([enemy isAlive]) {
            alive++;
        }
    }
    return alive;
}

- (NSString *) getHeroHealthSummary {
    return [NSString stringWithFormat:@"%d/%d", self.hero.health, [self.hero getMaxHealthThisLevel]];
}

- (NSString *) getHeroManaSummary {
    return [NSString stringWithFormat:@"%d/%d", self.hero.mana, [self.hero getMaxManaThisLevel]];
}

- (float) getHeroHealthPercent {
    return (float) self.hero.health / [self.hero getMaxHealthThisLevel];
}
- (float) getHeroManaPercent {
    return (float) self.hero.mana / [self.hero getMaxManaThisLevel];
}

- (BOOL) attackEnemyAtIndex:(long)index {
    BOOL success = NO;
    Enemy *tmp = [self.enemies objectAtIndex:index];
    if ([tmp isAlive]) {
        success = YES;
        long attackPoints = [self.hero getAttack];
        NSLog(@"Hero attacks enemy at index %lu for %lu damage", index, attackPoints);
        [tmp alterGameEntityHealthByInt:(-(int)attackPoints)];
    } else {
        NSLog(@"Enemy is dead. No attack applied.");
    }
    return success;
}

- (BOOL) attackEnemiesWithSpell {
    BOOL success = NO;
    if ([self.hero canCastSpell] && [self getLivingEnemyCount] > 0) {
        [self.hero rechargeManaWithOffset:15];
        long attackPoints = [self.hero getSpellAttack];
        for (Enemy *e in self.enemies) {
            if ([e isAlive]) {
                success = YES;
                [e alterGameEntityHealthByInt:-(int)attackPoints];
            }
        }
    }
    return success;
}

@end
