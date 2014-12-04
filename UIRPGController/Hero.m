//
//  Character.m
//  UIRPGController
//
//  Created by Sean on 10/6/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import "Hero.h"

@interface Hero ()

@end

@implementation Hero

NSString * const HERO_SAVE_STRING = @"hero";
int const SPELL_CAST_MANA_COST = 10;
int const MANA_POINT_RECHARGE_STEP_SECS = 1;

-(NSArray *)getAttributeValueAndNameStringsAtIndex:(long)value {
    NSString *valueString;
    NSString *valueLabel;
    if (value == Name) {
        valueString = self.name;
        valueLabel = @"Hero Name";
    } else if (value == Level) {
        valueString = [NSString stringWithFormat:@"%i", self.level];
        valueLabel = @"Level";
    } else if (value == Health) {
        valueString = [NSString stringWithFormat:@"%i", self.health];
        valueLabel = @"Health";
    } else if (value == Mana) {
        valueString = [NSString stringWithFormat:@"%i", self.mana];
        valueLabel = @"Mana";
    } else if (value == XP) {
        valueString = [NSString stringWithFormat:@"%i", self.xpToLevel];
        valueLabel = @"XP to Level";
    }
    return [[NSArray alloc] initWithObjects:valueString, valueLabel, nil];
}

-(BOOL)canCastSpell {
    return self.mana > 0;
}

-(long) getSpellAttack {
    [self alterGameEntityManaByInt:-SPELL_CAST_MANA_COST];
    return [self getAttack];
}

- (void) incrementHeroMana {
    [self alterGameEntityManaByInt:1];
}

- (void)rechargeManaWithOffset:(int)offset {
    int steps = SPELL_CAST_MANA_COST;
    if (steps)
    
    for (int i = 0; i < steps; i++) {
        [self performSelector:@selector(incrementHeroMana) withObject:self afterDelay:offset + MANA_POINT_RECHARGE_STEP_SECS];
    }
}

-(void)rechargeMana {
    [self rechargeManaWithOffset:5];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"Hero:\n\tName=%@ Level=%d Health=%d Mana=%d XP Earned=%d (%d needed)", self.name, self.level, self.health, self.mana, ([self getXPThisLevel] - self.xpToLevel), [self getXPThisLevel]];
}

@end
