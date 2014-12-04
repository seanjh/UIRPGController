//
//  Character.h
//  UIRPGController
//
//  Created by Sean on 10/6/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameEntity.h"
#import "GameAssistant.h"

@interface Hero : GameEntity

extern NSString * const HERO_SAVE_STRING;
extern int const SPELL_CAST_MANA_COST;
extern int const MANA_POINT_RECHARGE_STEP_SECS;

//+(Hero *)getHeroFromSave;
//-(void)saveHero;
//-(void)deleteHero;
-(NSArray *)getAttributeValueAndNameStringsAtIndex:(long)value;
-(BOOL)canCastSpell;
-(long) getSpellAttack;
-(void)rechargeMana;
- (void)rechargeManaWithOffset:(int)offset;

@end
