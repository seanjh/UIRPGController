//
//  GameEntity.h
//  UIRPGController
//
//  Created by Sean on 10/10/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameEntity : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) int level;
@property (nonatomic) int health;
@property (nonatomic) int mana;
@property (nonatomic) int xpToLevel;
@property (nonatomic) int cooldownSeconds;

extern const int COOLDOWN_DEFAULT;
extern const int XP_LEVEL_MULTIPLIER;
extern const int HEALTH_MANA_LEVEL_MULTIPLIER;
extern const int DAMAGE_MAX_LEVEL_MULTIPLIER;
extern NSString * const GAME_ENTITY_SAVE_STRING;

typedef enum {
    Name, Health, Mana, Level, XP, Cooldown
} Attribute;

- (id)init;
- (id)initWithNameString:(NSString *) entityName;
- (id)initWithNameString:(NSString *) entityName andLevelNumber:(int) levelNumber;

// via http://stackoverflow.com/questions/2315948/how-to-store-custom-objects-in-nsuserdefaults
+ (void)saveGameEntity:(id)object key:(NSString *)key;
+ (id)loadGameEntityWithKey:(NSString *)key;
+ (void)deleteGameEntityWithKey:(NSString *)key;
- (NSDictionary *)serializeGameEntity;

- (void)alterGameEntityHealthByInt:(int) value;
- (void)alterGameEntityManaByInt:(int) value;
- (void)alterGameEntityXPByInt:(int) value;
- (void)levelUp;
- (int)getXPThisLevel;
- (int)getMaxHealthThisLevel;
- (int)getMaxManaThisLevel;

- (BOOL)isInProgress;
- (BOOL)isAlive;

- (BOOL)canAttack;
- (long)getAttack;

@end
